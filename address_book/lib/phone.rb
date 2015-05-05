class Phone

  attr_reader(:phone, :type, :person_id)

  def initialize (attributes)
    @phone = attributes.fetch(:phone)
    @type = attributes.fetch(:type)
    @person_id = attributes.fetch(:person_id)
  end

  define_singleton_method(:all) do
    returned_phones = DB.exec("SELECT * FROM phone")
    phones = []
    returned_phones.each do |phone|
      number = phone.fetch("phone").to_i
      type = phone.fetch("type")
      person_id = phone.fetch("person_id").to_i
      phones.push(Phone.new({:phone => number, :type => type, :person_id => person_id}))
    end
    phones
  end

  def save
    DB.exec("INSERT INTO phone (phone, type, person_id) VALUES(#{@phone}, '#{@type}', '#{@person_id}');")

  end
end
