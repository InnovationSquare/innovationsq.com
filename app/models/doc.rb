class Doc
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :title, :type => String

  field :comments_count, :type => Integer, :default => 0

  field :scribd_doc_id, :type => String
  field :scribd_doc_access_key, :type => String
  field :thumbnail_url, :type => String

  field :conversion_status, :type => String
  field :ready, :type => Boolean, :default => false

  belongs_to :company
  belongs_to :creator, :class_name => "Person", :inverse_of => :docs
  belongs_to :isotope, :inverse_of => :attached_to

  attr_accessible :title, :company, :creator, :scribd_doc_id, :scribd_doc_access_key, :thumbnail_url

  before_create :create_isotope
  after_create :inc_counter_cache
  after_destroy :dec_counter_cache

  class << self

    def upload!(title, company, creator, file_path)

      Scribd::User.login ENV['SCRIBD_USERNAME'], ENV['SCRIBD_PASSWORD']
      scribd_doc = Scribd::Document.upload(:file => file_path, :access => "private")

      if scribd_doc.saved?
        doc = Doc.new :title => title, :company => company, :creator => creator, :scribd_doc_id => scribd_doc.id.to_s, :scribd_doc_access_key => scribd_doc.access_key, :thumbnail_url => scribd_doc.thumbnail_url(:width => 220, :height => 220)
        doc.set_conversion_status scribd_doc.conversion_status
        doc.save!
        doc
      else
        nil
      end
    end

    def with_id(param)
      id = param.to_s.split('-').last
      Doc.find id
    end

  end

  def create_isotope
    self.isotope = Isotope.create :verb => "uploaded a document", :copy => self.title, :person => self.creator, :attached_to => self.company, :topic => self, :topic_url => "/#{self.company.handle}/docs/#{self.to_param}"
  end

  def set_conversion_status(status)
    self.conversion_status = status
    self.ready = true if status == "READY"
  end

  def embed_src
    "http://www.scribd.com/embeds/#{scribd_doc_id}/content?start_page=1&view_mode=list&access_key=#{scribd_doc_access_key}"
  end

  def inc_counter_cache
    self.company.inc :docs_count, 1
  end

  def dec_counter_cache
    self.company.inc :docs_count, -1
  end

  def to_param
    "#{self.title.parameterize}-#{self.id}"
  end

end