require 'spec_helper'

describe Category do
  describe '#initialize' do
    it 'initializes an instance of Category' do
      new_category = Category.new({})
      new_category.should be_an_instance_of Category
    end
  end

  describe '.all' do
    it 'returns an array of all the categories in the database' do
      Category.all.should eq []
    end
    it 'returns an array with the elements' do
      test_category = Category.create({'name' => 'food'})
      Category.all[0].name.should eq 'food'
    end
  end

  describe '#save' do
    it 'adds self to database' do
      test_category = Category.new({ 'name' => 'Josh' })
      test_category.save
      Category.all.should eq [test_category]
    end
  end

  describe '#==' do
    it 'checks for equality, returns true if name is the same' do
      test_category1 = Category.new({ 'name' => 'Josh' })
      test_category2 = Category.new({ 'name' => 'Josh' })
      test_category1.should eq test_category2
    end
  end

  describe '#name=' do
    it 'set name attribute and updates corresponding field in database' do
      test_category = Category.new({ 'name' => 'Josh'})
      test_category.save
      test_category.name = 'Patrick'
      result = DB.exec("SELECT * FROM category WHERE name = 'Patrick';")
      test_category.name.should eq 'Patrick'
      result.count.should eq 1
    end
  end
end
