class Company
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    all_companies = []
    results = DB.exec('SELECT * FROM company;')
    results.each do |result|
      new_company = Company.new(result)
      all_companies << new_company
    end
    all_companies
  end

  def self.create(attributes)
    new_company = Company.new(attributes)
    new_company.save
    new_company
  end

  def save
    returned_id = DB.exec("INSERT INTO company (name) VALUES ('#{@name}') RETURNING id;")
    @id = returned_id.first['id']
  end

  def ==(another_company)
    self.name == another_company.name
  end

  def name=(name)
    @name = name
    DB.exec("UPDATE company SET name = '#@name' WHERE id = #@id;")
  end
end
