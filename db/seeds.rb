
Company.delete_all
Person.delete_all
Doc.delete_all
Isotope.delete_all
Recommendation.delete_all

p = Person.create :username => "cw", :first_name => "C", :last_name => "W"

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

catalyst = Company.create :name => "Uptown Alliance", :handle => "uptown", :district => "Creative District", :city => "Raleigh", :description => "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis netus et dae"
catalyst.creator = p
catalyst.staff << p
catalyst.save

p.recommend! bio
p.follow! bio
p.follow! catalyst
