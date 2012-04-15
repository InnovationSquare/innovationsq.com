class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comments, :type => String

  belongs_to :company
  belongs_to :person

  belongs_to :isotope, :inverse_of => :attached_to

  attr_accessible :person, :company, :comments

  before_create :create_isotope
  after_create :inc_counter_cache
  after_destroy :dec_counter_cache

  class << self

    def make!(person, company, comments='')
      return false if Recommendation.company_recommended_by?(company, person)
      r = Recommendation.new :person => person, :company => company, :comments => comments
      r.save
      r
    end

    def company_recommended_by?(company, person)
      where(:company_id => company.id, :person_id => person.id).count == 1
    end

  end

  def create_isotope
    self.isotope = Isotope.create :verb => "recommends", :copy => self.company.name, :person => self.person, :attached_to => self.company, :topic => self.company, :topic_url => "/#{self.company.handle}"
  end

  def inc_counter_cache
    self.company.inc :recommendations_count, 1
  end

  def dec_counter_cache
    self.company.inc :recommendations_count, -1
  end

end