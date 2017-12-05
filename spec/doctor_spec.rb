require('rspec')
require('pg')
require('doctor')
# require('patient')
# require('spec_helper')

DB = PG.connect({:dbname => 'test_doctors_office'})

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
