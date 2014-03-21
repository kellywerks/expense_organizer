require  'rspec'
require  'category'
require  'company'
require  'person'
require  'expense'
require  'pg'

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expense *;")
    DB.exec("DELETE FROM category *;")
    DB.exec("DELETE FROM company *;")
    DB.exec("DELETE FROM person *;")
  end
end
