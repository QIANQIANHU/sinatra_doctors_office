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
