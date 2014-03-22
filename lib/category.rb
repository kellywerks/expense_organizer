class Category
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.create(attributes)
    new_category = Category.new(attributes)
    new_category.save
    new_category
  end

  def self.all
    all_categories = []
    results = DB.exec('SELECT * FROM category;')
    results.each do |result|
      new_category = Category.new(result)
      all_categories << new_category
    end
    all_categories
  end

  def save
    returned_id = DB.exec("INSERT INTO category (name) VALUES ('#{@name}') RETURNING id;")
    @id = returned_id.first['id']
  end

  def ==(another_category)
    self.name == another_category.name
  end

  def name=(name)
    @name = name
    DB.exec("UPDATE category SET name = '#@name' WHERE id = #@id;")
  end

  def delete_category
    DB.exec("DELETE FROM category WHERE id = #{@id};")
    #ASSOCIATED EXPENSES NEED TO BE REASSIGNED
  end
end
