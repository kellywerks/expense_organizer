require 'spec_helper'

describe Company do
  describe '#initialize' do
    it 'initializes an instance of Company' do
      new_company = Company.new({})
      new_company.should be_an_instance_of Company
    end
  end

  describe '.all' do
    it 'returns an array of all the companies in the database' do
      Company.all.should eq []
    end
  end

  describe '#save' do
    it 'adds self to database' do
      test_company = Company.new({ 'name' => 'Apple' })
      test_company.save
      Company.all.should eq [test_company]
    end
  end

  describe '#==' do
    it 'checks for equality, returns true if name is the same' do
      test_company1 = Company.new({ 'name' => 'Apple' })
      test_company2 = Company.new({ 'name' => 'Apple' })
      test_company1.should eq test_company2
    end
  end

  describe '#name=' do
    it 'set name attribute and updates corresponding field in database' do
      test_company = Company.new({ 'name' => 'Apple'})
      test_company.save
      test_company.name = 'Microsoft'
      result = DB.exec("SELECT * FROM company WHERE name = 'Microsoft';")
      test_company.name.should eq 'Microsoft'
      result.count.should eq 1
    end
  end
end
