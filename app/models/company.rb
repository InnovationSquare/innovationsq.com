class Company
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :name, :type => String
  field :handle, :type => String
  index :handle, :unique => true

  attr_accessible :name

  before_save :set_handle

  class << self

    def with_handle(handle)
      where(:handle => handle).limit(1).first
    end

  end

  def ensure_unique_url
    true
  end

  def to_param
    handle
  end

  def set_handle
    self.handle = name.parameterize if self.handle.blank?
  end

end