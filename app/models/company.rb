class Company
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :name, :type => String
  field :handle, :type => String
  index :handle, :unique => true

  field :recommendations_count, :type => Integer, :default => 0
  field :docs_count, :type => Integer, :default => 0
  field :members_count, :type => Integer, :default => 0

  field :district, :type => String
  field :city, :type => String
  field :state, :type => String

  field :changing_line, :type => String
  field :description, :type => String

  field :hiring, :type => Boolean, :default => false
  field :seeking_investors, :type => Boolean, :default => false
  field :startup, :type => Boolean, :default => false

  has_one :creator, :class_name => "Person", :inverse_of => :created_companies

  has_and_belongs_to_many :founders, :class_name => "Person", :inverse_of => :founded_companies
  has_and_belongs_to_many :investors, :class_name => "Person", :inverse_of => :invested_companies
  has_and_belongs_to_many :staff, :class_name => "Person", :inverse_of => :staff_companies

  has_and_belongs_to_many :followers, :class_name => "Person", :inverse_of => :following

  has_many :docs
  has_many :isotopes, :as => :attached_to
  belongs_to :pitch_deck, :class_name => "Doc"

  attr_accessible :name, :handle, :district, :city, :state

  before_save :set_handle

  class << self

    def with_handle(handle)
      where(:handle => handle).limit(1).first
    end

  end

  def recommended_by?(person)
    Recommendation.company_recommended_by?(self, person)
  end

  def followed_by?(person)
    self.followers.include?(person)
  end

  def has_pitch_deck?
    !self.pitch_deck_id.blank?
  end

  def to_param
    handle
  end

  def set_handle
    self.handle = name.parameterize if self.handle.blank?
  end

end