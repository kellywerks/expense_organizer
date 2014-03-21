class Person
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    all_people = []
    results = DB.exec('SELECT * FROM person;')
    results.each do |result|
      new_person = Person.new(result)
      all_people << new_person
    end
    all_people
  end

  def save
    returned_id = DB.exec("INSERT INTO person (name, id) VALUES ('#{@name}', #{@id}) RETURNING id;")
    @id = returned_id.first['id']
  end

  def ==(another_person)
    self.name == another_person.name
  end

  def name=(name)
    @name = name
    DB.exec("UPDATE person SET name = '#@name' WHERE id = #@id;")
  end
end
