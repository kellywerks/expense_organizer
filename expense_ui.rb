require './lib/person'
require './lib/company'
require './lib/category'
require './lib/expense'
require './lib/replacegets'
require 'pg'


DB = PG.connect({:dbname => 'expense_organizer'})

def welcome
  puts "Welcome to the expense tracker!"
  puts "What is your name?"
  user_input = gets.chomp
  @user = Person.new({'name' => user_input}).save
  main_menu
end

def main_menu
  puts "\n\n\n"
  puts "******************** Welcome to the Expense Organizer *******************"
  puts "ADD Options:"
  puts "1 - Add an expense"
  puts "2 - Add a category"
  puts "DELETE Options:"
  puts "3 - Delete an expense"
  puts "4 - Delete a category"
  puts "REPORT Options:"
  puts "L - List all expenses"
  puts "C - List all categories with percent of total expenditures calculated."
  puts "Choose an option or select 'X' to exit.\n"

  case gets.chomp.to_s.downcase
  when "1"
    add_expense
  when "2"
    add_category
  when '3'
    system("clear")
    delete_expense
  when '4'
    system("clear")
    delete_category
  when "l"
    system("clear")
    list_expenses
    gets
    main_menu
  when 'c'
    system("clear")
    category_expenses
    gets
    main_menu
  when 'x'
    puts "Oh no! We will miss you!"
    puts "(づ ￣ ³￣)づ "
  else
    puts 'Invalid input'
  end
end

def add_expense
  puts "Enter the name of your expense"
  name = gets.downcase.chomp
  puts "Enter the amount"
  amount = gets.chomp
  puts "Enter the date of your purchase"
  date = gets.chomp
  puts "Enter the company you purchased from"
  company = gets.chomp
  puts "Enter a category for this purchase"
  category = gets.chomp

  new_category = Category.create({'name' => category})
  new_company = Company.create({'name' => company})
  new_expense = Expense.create({'name' => name, 'amount' => amount, 'date' => date,
    'company_id' => new_company.id, 'person_id' => @user, 'category_id' => new_category.id})
  main_menu
end

def add_category
  puts "\nHere is the current list of categories:\n"
  Category.all.sort_by{|category| category.name}.each_with_index do |category, index|
    puts "#{index + 1}. #{category.name}"
  end

  puts "\nEnter a new category for your organizer:"
  user_input = gets.chomp
  new_category = Category.create({'name' => user_input})
  puts "Would you like to enter another (y/n)?"
  user_input = gets.chomp
  if user_input == 'y'
    add_category
  else
    main_menu
  end
  main_menu
end

def delete_expense
  list_expenses
  puts "what expense would you like to remove? (enter the id)"
  to_delete = gets.chomp.to_i
  Expense.all[to_delete].delete_expense
  # Expense.delete_expense(to_delete)
  main_menu
end

def delete_category
  puts "\nHere is the current list of categories:\n"
  Category.all.sort_by{|category| category.name}.each_with_index do |category, index|
    puts "#{index + 1}. #{category.name}"
  end

  puts "Enter the number of the category to delete"
  to_delete = gets.chomp.to_i
  Category.all.sort_by{|category| category.name}[to_delete - 1].delete_category

  main_menu
end

def list_expenses
  Expense.all.each_with_index do |expense, index|
    puts "#{index+1}. #{expense.name}, Price: $#{expense.amount}, #{expense.date}, ID: #{expense.id}"
  end
end

def category_expenses
  Expense.total_expense_percentage.each do |category|
    category_name = Expense.fetch_category_name(category[0])
    puts "#{category_name}, #{category[1].round(2)}"
  end
end

main_menu
