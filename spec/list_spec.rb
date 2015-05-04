require('rspec')
require('list')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'to_do_list_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe(List) do
  describe('.all') do
    it('empty at first') do
      expect(List.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is the same list if it has the same name') do
      list1 = List.new({:name => "Monday", :id => nil})
      list2 = List.new({:name => "Monday", :id => nil})
      expect(list1).to(eq(list2))
    end
  end
  describe('#save') do
    it('saves lists into database') do
      list = List.new({:name => "FRIDAY", :id => nil})
      list.save()
      expect(List.all).to(eq([list]))
    end
  end
end
