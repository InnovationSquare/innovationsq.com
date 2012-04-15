
Company.delete_all
Person.delete_all
Doc.delete_all
Isotope.delete_all
Recommendation.delete_all

p = Person.create :username => "sirwalter", :first_name => "Sir Walter", :last_name => "Raleigh", :title => "City Organizer"

startup = Company.create :name => "StartupApp.com", :handle => "startup", :district => "North", :city => "Raleigh", :changing_line => "We are changing apps", :description => "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis netus et dae"
startup.pitch_deck = Doc.upload! "The Pitch", startup, p, Rails.root.join('db','seeds','mint-pitch-deck.pdf')
startup.hiring = true
startup.seeking_investors = true
startup.startup = true
startup.creator = p
startup.founders << p
startup.save

bio = Company.create :name => "Biotech & Engineering Corp", :handle => "biotech", :district => "Downtown", :city => "Raleigh", :changing_line => "We are changing biotech", :description => "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis netus et dae"
bio.creator = p
bio.staff << p
bio.save

dra_attr = { :name => "Downtown Raleigh Alliance",
  :handle => "dra",
  :district => "Downtown",
  :city => "Raleigh",
  :description => "Downtown Raleigh lies at the heart of the Triangle, the fastest growing metropolitan region in the Carolinas. For businesses, residents and visitors alike, downtown is the urban center of the region, an incredible place to live, work and play.",
  :website_url => "http://www.godowntownraleigh.com/",
  :twitter_handle => "downtownraleigh",
  :facebook_url => "http://www.facebook.com/downtownraleigh",
  :linkedin_url => "http://www.linkedin.com/groups/Downtown-Raleigh-Alliance-3706299"
}
dra = Company.create dra_attr
dra.creator = p
dra.staff << p
dra.save

Doc.upload! "Downtown Raleigh", dra, p, Rails.root.join('db','seeds','downtown-raleigh.pdf')
Doc.upload! "Map of the Business Improvement District", dra, p, Rails.root.join('db','seeds','business-improvement-district.pdf')
#Doc.upload! "Pedestrian Count Study", dra, p, Rails.root.join('db','seeds','pedestrian-count-study.pdf')
Doc.upload! "Fourth Quarter 2011", dra, p, Rails.root.join('db','seeds','fourth-quarter-2011.pdf')
#Doc.upload! "2011 Annual Report", dra, p, Rails.root.join('db','seeds','2011-annual-report.pdf')

p.recommend! bio
p.follow! bio
p.follow! dra
