class Person
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :username, :type => String
  field :handle, :type => String
  index :handle, :unique => true

  field :first_name, :type => String
  field :last_name, :type => String

  field :title, :type => String

  belongs_to :created_companies, :class_name => "Company", :inverse_of => :creator
  has_and_belongs_to_many :founded_companies, :class_name => "Company", :inverse_of => :founders

  attr_accessible :username, :first_name, :last_name

  before_save :set_handle

  class << self

    def with_handle(handle)
      where(:handle => handle).limit(1).first
    end

  end

  def to_param
    handle
  end

  def set_handle
    self.handle = username.parameterize
  end

end