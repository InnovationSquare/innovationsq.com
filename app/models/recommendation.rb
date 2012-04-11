class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comments, :type => String

  belongs_to :company
  belongs_to :person

  belongs_to :isotope

  attr_accessible :person, :company, :comments

  class << self

    def make!(person, company, comments='')
      r = Recommendation.new :person => person, :company => company, :comments => comments
      r.isotope = Isotope.create :verb => "recommends", :copy => company.name, :person => person, :attached_to => company
      r.save
      r
    end

  end

end