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

  field :website_url, :type => String
  field :twitter_handle, :type => String
  field :facebook_url, :type => String
  field :linkedin_url, :type => String
  field :demo_url, :type => String

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
  belongs_to :isotope

  attr_accessible :creator, :name, :handle, :district, :city, :state, :changing_line, :description, :website_url, :twitter_handle, :facebook_url, :linkedin_url, :demo_url

  before_save :set_handle
  before_create :create_isotope

  class << self

    def with_handle(handle)
      where(:handle => handle.to_s).limit(1).first
    end

  end

  def create_isotope
    self.isotope = Isotope.create :verb => "added", :copy => self.name, :person => self.creator, :attached_to => self, :topic => self, :topic_url => "/#{self.handle}"
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