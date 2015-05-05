require('rspec')
require('contact')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'address_book_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM contacts *;")
  end
end


describe(Contact) do
  describe('#save') do
    it('saves contact into database') do
      new_contact =  Contact.new(:name => "Erin", :id => nil)
      new_contact.save()
      expect(Contact.all()).to(eq([new_contact]))
    end
  end

  describe('#==') do
    it('is the same contact if it has the same name') do
      new_contact1 =  Contact.new(:name => "Erin", :id => nil)
      new_contact2 =  Contact.new(:name => "Erin", :id => nil)
      expect(new_contact1).to(eq(new_contact2))
    end
  end
end
