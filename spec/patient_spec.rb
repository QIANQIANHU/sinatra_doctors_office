require('rspec')
require('pg')
require('doctor')
# require('patient')
require('spec_helper')

DB = PG.connect({:dbname => 'doctors_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end

describe(Patient) do

  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new({:name => "Malgorzata Haniszewska", :birthdate => "2017-07-23 00:00:00", :doctor_id => 1})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe("#name") do
    it("lets you read the name out") do
      test_patient = Patient.new({:name => "Malgorzata Haniszewska", :birthdate => "2017-07-23 00:00:00", :doctor_id => 1})
      expect(test_patient.name()).to(eq("Malgorzata Haniszewska"))
    end
  end

  describe("#doctor_id") do
    it("lets you read the doctor ID out") do
      test_patient = Patient.new({:name => "Malgorzata Haniszewska", :birthdate => "2017-07-23 00:00:00", :doctor_id => 1})
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name, birthdate and doctor ID") do
      test_patient1 = Patient.new({:name => "Malgorzata Haniszewska", :birthdate => "2017-07-23 00:00:00", :doctor_id => 1})
      test_patient2 = Patient.new({:name => "Malgorzata Haniszewska", :birthdate => "2017-07-23 00:00:00", :doctor_id => 1})
    end
  end

end
