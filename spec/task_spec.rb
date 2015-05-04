require('rspec')
require('task')
require('list')
require('pg')

DB = PG.connect({:dbname => 'to_do_list_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do
  describe('#==') do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1})
      task2 = Task.new({:description => "learn SQL", :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Task.all).to(eq([]))
    end
  end

  describe('#save') do
    it('will save each task to array of tasks') do
      test_task = Task.new({:description => "Walk the pig", :list_id => 1})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#list_id') do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "Buy candy", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end
end
