
Company.delete_all
Person.delete_all
Doc.delete_all

c = Company.create :name => "Biotech & Engineering Corp", :handle => "biotech"

p = Person.create :username => "cw"

c.pitch_deck = Doc.upload! "The Pitch", c, p, Rails.root.join('db','seeds','mint-pitch-deck.pdf')

c.creator = p
c.founders << p
c.save
