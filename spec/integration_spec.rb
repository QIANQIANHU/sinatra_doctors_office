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
    click_button('Add to List')
    expect(page).to have_content('Add Patient')
  end
end

# describe('viewing all of the lists', {:type => :feature}) do
#   it('allows a user to see all of the lists that have been created') do
#     list = List.new({:name => 'Epicodus Homework', :id => nil})
#     list.save()
#     visit('/')
#     click_link('View All Lists')
#     expect(page).to have_content(list.name)
#   end
# end
#
# describe('seeing details for a single list', {:type => :feature}) do
#   it('allows a user to click a list to see the tasks and details for it') do
#     test_list = List.new({:name => 'School stuff', :id => nil})
#     test_list.save()
#     test_task = Task.new({:description => "learn SQL", :list_id =>
#     test_list.id()})
#     test_task.save()
#     visit('/lists')
#     click_link(test_list.name())
#     expect(page).to have_content(test_task.description())
#   end
# end
#
# describe('adding tasks to a list', {:type => :feature}) do
#   it('allows a user to add a task to a list') do
#     test_list = List.new({:name => 'School stuff', :id => nil})
#     test_list.save()
#     visit("/lists/#{test_list.id()}")
#     fill_in("Description", {:with => "Learn SQL"})
#     click_button("Add task")
#     expect(page).to have_content("Success")
#   end
# end
