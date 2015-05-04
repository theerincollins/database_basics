class Task
  attr_reader(:description)

  define_method(:initialize) do |attributes|

    @description = attributes.fetch(:description)

  end

  define_method(:==) do |other_task|
    self.description().eql?(other_task.description())
  end


  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each do |task|
      description = task.fetch("desciption")
      tasks.push(Task.new({:description => description}))
    end
    tasks
  end
end
