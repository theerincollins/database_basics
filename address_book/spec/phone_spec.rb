require('rspec')
require('phone')
require('pg')
require('pry')
require('contact')

DB = PG.connect({:dbname => 'address_book_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM phone *;")
  end
end

describe(Phone) do
  describe('#save') do
    it('saves to database and returns it') do
      test_phone = Phone.new({:phone => 6724236, :type => 'cell', :person_id => 3 })
      test_phone.save
      expect(Phone.all).to(eq([test_phone]))
    end
  end
end
