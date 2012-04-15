class Isotope
  include Mongoid::Document
  include Mongoid::Timestamps

  field :verb, :type => String
  field :copy, :type => String

  field :person_name, :type => String
  field :topic_url, :type => String

  belongs_to :attached_to, :polymorphic => true
  belongs_to :topic, :polymorphic => true
  belongs_to :person

  attr_accessible :verb, :copy, :person, :attached_to, :topic, :topic_url

  before_save :set_names

  class << self

    def for_companies(company_ids)
      where(:attached_to.in => company_ids).desc(:created_at)
    end

  end

  def text
    [person_name, verb, copy].compact.join ' '
  end

  def set_names
    self.person_name = self.person.full_name unless self.person.blank?
  end

end