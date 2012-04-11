
Company.delete_all
Person.delete_all
Doc.delete_all
Isotope.delete_all
Recommendation.delete_all

c = Company.create :name => "Biotech & Engineering Corp", :handle => "biotech"

p = Person.create :username => "cw", :first_name => "C", :last_name => "W"

#c.pitch_deck = Doc.upload! "The Pitch", c, p, Rails.root.join('db','seeds','mint-pitch-deck.pdf')

c.creator = p
c.founders << p
c.save

p.recommend! c