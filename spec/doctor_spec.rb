require('rspec')
require('pg')
# require('doctor')
require('patient')
require('spec_helper')

DB = PG.connect({:dbname => 'doctors_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe(Doctor) do
  describe(".all") do
    it("starts off with no doctors on list") do
      expect(Doctor.all()).to(eq([]))
    end
  end
end

  describe("#name") do
     it("tells you each doctors name") do
       doctors_list = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
       expect(doctors_list.name()).to(eq("Pamela Frost"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      doctors_list = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
      doctors_list.save()
      expect(doctors_list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save doctors list to the database") do
      doctors_list = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
      doctors_list.save()
      expect(Doctor.all()).to(eq([doctors_list]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      doctors_list1 = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
      doctors_list2 = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
      expect(doctors_list1).to(eq(doctors_list2))
    end
  end

  describe(".find") do
    it("returns a doctor by its ID") do
      doctors_list1 = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
      doctors_list1.save()
      doctors_list2 = Doctor.new({:name => "Kevin Babcock",:speciality => "dentist", :id => nil})
      doctors_list2.save()
      expect(Doctor.find(doctors_list2.id())).to(eq(doctors_list2))
    end
  end
