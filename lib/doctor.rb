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
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      speciality = doctor.fetch("speciality")
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name,:speciality => speciality, :id => id}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, speciality) VALUES ('#{@name}','#{@speciality}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_list)
    self.name().==(another_list.name()).&(self.id().==(another_list.id())).&(self.speciality().==(another_list.speciality()))
  end

  def self.find(id)
    found_list = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_list = doctor
      end
    end
    found_list
  end
end
