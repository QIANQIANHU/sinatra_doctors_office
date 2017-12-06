require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('viewing administrator page', {:type => :feature}) do
  it('allows a user to click a link to see administrator page') do
    visit('/')
    click_link('Click here if you are an Administrator')
    expect(page).to have_content('Please choose if you want to add doctor or patient')
  end
end

describe('viewing doctors list page', {:type => :feature}) do
  it('allows a user to click a link to see doctors list page') do
    visit('/')
    click_link('Click here if you are a Doctor')
    expect(page).to have_content('The List of Doctors')
  end
end

describe('adding doctor to list', {:type => :feature}) do
  it('allows administrator to add a new doctor to a list') do
    visit('/form_doctor')
    fill_in('name', with: 'Pamela Frost')
    fill_in('speciality', with: 'family doctor')
    click_button('Add to List')
    expect(page).to have_content('Please choose if you want to add doctor or patient')
  end
end

describe('adding patient to list', {:type => :feature}) do
  it('allows administrator to add a new patient to a list') do
    visit('/form_patient')
    fill_in('name', with: 'Malgorzata Haniszewska')
    fill_in('birthdate', with: '2017-07-23 00:00:00')
    fill_in('doctor_id', with: 1)
    # save_and_open_page
    click_button('Add to List')
    expect(page).to have_content('Add Patient')
  end
end

describe('viewing all of the doctors', {:type => :feature}) do
  it('allows a user to see all of the doctors that have been created') do
    doctors = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
    doctors.save()
    visit('/')
    click_link('Click here if you are a Doctor')
    expect(page).to have_content(doctors.name)
  end
end

describe('seeing details for a single doctor', {:type => :feature}) do
  it('allows a user to click on a doctor to see the patients for him or her') do
    test_doctor = Doctor.new({:name => "Pamela Frost",:speciality => "family doctor", :id => nil})
    test_doctor.save()
    test_patient = Patient.new({:name => "Malgorzata Haniszewska",:birthdate => "2017-07-23", :doctor_id => test_doctor.id})
    test_patient.save()
    visit('/doctors_list')

    click_link(test_doctor.name())
    save_and_open_page
    expect(page).to have_content(test_patient.name())
  end
end
