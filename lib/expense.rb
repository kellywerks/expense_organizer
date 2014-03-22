class Expense
  attr_reader :id, :name, :amount, :date, :company_id, :person_id, :category_id

  def initialize(attributes)
    @name = attributes['name']
    @amount = attributes['amount'].to_f
    @date = attributes['date']
    @company_id = attributes['company_id'].to_i
    @person_id = attributes['person_id'].to_i
    @category_id = attributes['category_id'].to_i
    @id = attributes['id'].to_i
  end

  def self.create(attributes)
    new_expense = self.new(attributes)
    new_expense.save
    new_expense
  end


  def self.all
    list = []
    results = DB.exec("SELECT * FROM expense;")
    results.each do |result|
      list << Expense.new(result)
    end
    list
  end

  def delete_expense
  DB.exec("DELETE FROM expense WHERE id = #{@id};")
  end

  def self.total_expense
    results = DB.exec("SELECT sum(amount) FROM expense;")
    results.first['sum'].to_f
  end

  def self.category_expense(category_id)
    results = DB.exec("SELECT sum(amount) FROM expense WHERE category_id = #{category_id};")
    results.first['sum'].to_f
  end

  def self.total_expense_percentage
    percents = []
    category_ids = []

    self.all.each do |items|
      category_ids << items.category_id
    end

    category_ids.uniq.each do |ids|
      percents << [ids, self.category_expense(ids) / self.total_expense]
    end
    percents
  end

  def self.fetch_category_name(category_id)
    results = DB.exec("SELECT * FROM category WHERE id = #{category_id};")
      results.first['name']
  end

  def save
    result = DB.exec("INSERT INTO expense (name, amount, date, company_id, person_id, category_id) VALUES ('#{@name}', #{@amount}, (to_date('#{@date}', 'YYYY-MM-DD')), #{@company_id}, #{@person_id}, #{@category_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_expense)
    self.name == another_expense.name && self.id == another_expense.id
  end

  def amount=(amount)
    @amount = amount
    DB.exec("UPDATE expense SET amount = #@amount WHERE id = #@id;")
  end

  def name=(name)
    @name = name
    DB.exec("UPDATE expense SET name = '#@name' WHERE id = #@id;")
  end

  def date=(date)
    @date = date
    DB.exec("UPDATE expense SET date = '#@date' WHERE id = #@id;")
  end

  def company_id=(company_id)
    @company_id = company_id
    DB.exec("UPDATE expense SET company_id = #@company_id WHERE id = #@id;")
  end

  def person_id=(person_id)
    @person_id = person_id
    DB.exec("UPDATE expense SET person_id = #@person_id WHERE id = #@id;")
  end

  def category_id=(category_id)
    @category_id = category_id
    DB.exec("UPDATE expense SET category_id = #{category_id} WHERE id = #{@id};")
  end
end






