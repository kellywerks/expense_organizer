require 'spec_helper'

describe Person do
  describe '#initialize' do
    it 'initializes an instance of person' do
      new_person = Person.new({})
      new_person.should be_an_instance_of Person
    end
  end

  describe '.all' do
    it 'returns an array of all the persons in th database' do
      Person.all.should eq []
    end
  end

  describe '#save' do
    it 'adds self to database' do
      test_person = Person.new({ 'name' => 'Josh' })
      test_person.save
      Person.all.should eq [test_person]
    end
  end

  describe '#==' do
    it 'checks for equality, returns true if name is the same' do
      test_person1 = Person.new({ 'name' => 'Josh' })
      test_person2 = Person.new({ 'name' => 'Josh' })
      test_person1.should eq test_person2
    end
  end

  describe '#name=' do
    it 'set name attribute and updates corresponding field in database' do
      test_person = Person.new({ 'name' => 'Josh'})
      test_person.save
      test_person.name = 'Patrick'
      result = DB.exec("SELECT * FROM person WHERE name = 'Patrick';")
      test_person.name.should eq 'Patrick'
      result.count.should eq 1
    end
  end
end
