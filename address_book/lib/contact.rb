class Contact

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_contacts = DB.exec("SELECT * FROM contacts;")
    contacts = []
    returned_contacts.each do |contact|
      name = contact.fetch("name")
      id = contact.fetch("id").to_i()
      contacts.push(Contact.new({:name => name , :id => id}))
    end
    contacts
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO contacts (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |other_name|
    (self.name == other_name.name) && (self.id == other_name.id)
  end

end
