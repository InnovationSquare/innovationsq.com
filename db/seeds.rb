
Company.delete_all
Person.delete_all
Doc.delete_all
Isotope.delete_all
Recommendation.delete_all

p = Person.create :username => "sirwalter", :first_name => "Sir Walter", :last_name => "Raleigh", :title => "Explorer"
si = Person.create :username => "iaculli", :first_name => "Steve", :last_name => "Iaculli", :title => "Entrepreneur"
j = Person.create :username => "joseph", :first_name => "Joseph", :last_name => "B.", :title => "CEO"

hb_attr = {
  :name => "HookBoard",
  :handle => "hb",
  :district => "Downtown",
  :city => "Raleigh",
  :changing_line => "We are changing online tutoring for higher education.",
  :description => "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis netus et dae",
  :website_url => "http://hookboard.com"
}
hb = Company.create hb_attr
hb.pitch_deck = Doc.upload! "Pitch Deck - Screenshots", hb, si, Rails.root.join('db','seeds','hb-pitch-deck.pdf')
hb.seeking_investors = true
hb.startup = true
hb.creator = si
hb.founders << si
hb.save

bio = Company.create :name => "Biotech & Engineering Corp", :handle => "biotech", :district => "Downtown", :city => "Raleigh", :changing_line => "We are changing biotech.", :description => "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis netus et dae"
bio.creator = j
bio.founders << j
bio.save

dra_attr = {
  :name => "Downtown Raleigh Alliance",
  :handle => "dra",
  :district => "Downtown",
  :city => "Raleigh",
  :changing_line => "The leader and champion for a vibrant and dynamic downtown.",
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
Doc.upload! "Pedestrian Count Study", dra, p, Rails.root.join('db','seeds','pedestrian-count-study.pdf')
Doc.upload! "Fourth Quarter 2011", dra, p, Rails.root.join('db','seeds','fourth-quarter-2011.pdf')
Doc.upload! "2011 Annual Report", dra, p, Rails.root.join('db','seeds','2011-annual-report.pdf')

p.recommend! bio
p.follow! bio
p.follow! dra
