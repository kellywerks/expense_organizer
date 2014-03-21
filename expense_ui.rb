require './lib/person'
require './lib/company'
require '.lib/category'
require 'pg'
require './lib/expense'
require 'replacegets'

DB = PG.connect({:dbname => 'expense_organizer'})

def welcome
  puts "Welcome to the expense tracker!"
  main_menu
end

def main_menu
  puts "A - Add an expense"
  puts "L - List all expenses"

  case gets.chomp
  when "A"
    add_expense
  when "L"
  else
    puts 'Invalid input'
  end
end

def add_expense
  puts "Enter the name of your expense"
  name = gets.chomp.downcase
  puts "Enter the amount"
  amount = gets.chomp
  puts "Enter the date of your purchase"
  date = gets.chomp
  puts "Enter the company you purchased from"
  company = gets.chomp
end
