require 'spec_helper'

describe Expense do
  describe 'initialize' do
    it 'initializes with with a name, amount, date, company, person, and category ids' do
      test_expense = Expense.new({'name' => "Burger", 'amount' => 5, 'date' => "1214-12-08", 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.should be_an_instance_of Expense
      test_expense.name.should eq "Burger"
    end
  end

  describe '#save' do
    it 'saves an Expense object to the expense table in the database' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      Expense.all.should eq [test_expense]
    end
  end

  describe '.all' do
    it 'starts out as an empty array because the Expense table is empty' do
      Expense.all.should eq []
    end
  end

  describe 'amount=' do
    it 'sets the amount of the expense object and modifies the database entry' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      test_expense.amount = 10.00
      result = DB.exec("SELECT * FROM expense WHERE amount = 10.00;")
      test_expense.amount.should eq 10.00
      result.count.should eq 1
    end
  end

  describe 'name=' do
    it 'sets the name of the expense object and modifies the database entry' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      test_expense.name = 'Gas'
      result = DB.exec("SELECT * FROM expense WHERE name = 'Gas';")
      test_expense.name.should eq 'Gas'
      result.count.should eq 1
    end
  end

  describe 'date=' do
    it 'sets the date of the expense object and modifies the database entry' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      test_expense.date = '2014-04-01'
      result = DB.exec("SELECT * FROM expense WHERE date = '2014-04-01';")
      test_expense.date.should eq '2014-04-01'
      result.count.should eq 1
    end
  end

  describe 'company_id=' do
    it 'sets the company_id of the expense object and modifies the database entry' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      test_expense.company_id = 3
      result = DB.exec("SELECT * FROM expense WHERE company_id = 3;")
      test_expense.company_id.should eq 3
      result.count.should eq 1
    end
  end

  describe 'person_id=' do
    it 'sets the person_id of the expense object and modifies the database entry' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      test_expense.person_id = 3
      result = DB.exec("SELECT * FROM expense WHERE person_id = 3;")
      test_expense.person_id.should eq 3
      result.count.should eq 1
    end
  end

  describe 'category_id=' do
    it 'sets the person_id of the expense object and modifies the database entry' do
      test_expense = Expense.new({'id' => 1, 'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense.save
      test_expense.category_id = 4
      result = DB.exec("SELECT * FROM expense WHERE category_id = 4;")
      test_expense.category_id.should eq 4
      result.count.should eq 1
    end
  end

  describe '.total_expense' do
    it 'gets the total expense of all purchases' do
      test_expense = Expense.create({'name' => "Burger", 'amount' => 5, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 3})
      test_expense2 = Expense.create({'name' => "Cat", 'amount' => 20.0, 'date' => '1214-12-08', 'company_id' => 1, 'person_id' => 2, 'category_id' => 3})
      Expense.total_expense.should eq 25.0
    end
  end

  describe '.category_expense' do
    it 'gets the total expense percentage of all purchases of that category' do
      test_expense = Expense.create({'name' => "Burger", 'amount' => 10.0, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 1})
      test_expense2 = Expense.create({'name' => "Cat", 'amount' => 20.0, 'date' => '1214-12-08', 'company_id' => 1, 'person_id' => 2, 'category_id' => 3})
      test_expense3 = Expense.create({'name' => "Dog", 'amount' => 70.0, 'date' => '1214-12-08', 'company_id' => 1, 'person_id' => 2, 'category_id' => 3})
      Expense.category_expense(3).should eq 90.0
    end
  end

  describe '.total_expense_percentage' do
    it 'gets all category expenses by percentage' do
      test_expense = Expense.create({'name' => "Burger", 'amount' => 10.0, 'date' => '1214-12-08', 'company_id' => 2, 'person_id' => 1, 'category_id' => 1})
      test_expense2 = Expense.create({'name' => "Cat", 'amount' => 20.0, 'date' => '1214-12-08', 'company_id' => 1, 'person_id' => 2, 'category_id' => 3})
      test_expense3 = Expense.create({'name' => "Dog", 'amount' => 70.0, 'date' => '1214-12-08', 'company_id' => 1, 'person_id' => 2, 'category_id' => 3})
      Expense.total_expense_percentage.should eq [[1, 0.1], [3, 0.9]]
    end
  end
end
