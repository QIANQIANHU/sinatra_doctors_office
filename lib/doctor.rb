class Doctor
  attr_reader(:name, :speciality, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @speciality = attributes.fetch(:speciality)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |list|
      name = doctors.fetch("name")
      speciality = doctors.fetch("speciality")
      id = doctors.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name,:speciality => speciality, :id => id}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
end
