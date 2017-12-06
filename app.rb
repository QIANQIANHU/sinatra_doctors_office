require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "doctors_office_test"})


get("/") do
  erb(:index)
end

get("/admin") do
  erb(:admin)
end

get("/doctors_list") do
  @doctors = Doctor.all()
  erb(:doctors_list)
end

get("/form_doctor") do
  erb(:form_doctor)
end

get("/form_patient") do
  erb(:form_patient)
end

post("/doctors") do
  name = params.fetch("name")
  speciality = params.fetch("speciality")
  doctor = Doctor.new({:name => name,:speciality => speciality, :id => nil})
  doctor.save()
  erb(:admin)
 end

 post("/patients") do
   name = params.fetch("name")
   birthdate = params.fetch("birthdate")
   doctor_id = params.fetch("doctor_id")
   patient = Patient.new({:name => name,:birthdate => birthdate, :doctor_id => doctor_id})
   patient.save()
   erb(:admin)
  end

get("/doctor/:id") do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end
