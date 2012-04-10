
Company.delete_all
Person.delete_all

c = Company.create :name => "Biotech & Engineering Corp", :handle => "biotech"

p = Person.create :username => "cw"

c.creator = p
c.founders << p
c.save
