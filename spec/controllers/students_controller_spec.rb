require_relative '../spec_helper'

describe StudentsController do
  # Every route should be within it's own context.
   let(:student){Student.new.tap{|s| s.name = "Flatiron Student"}}

  
  context 'GET /' do
    # student will be a new, unsaved student.

    # As your test suite grows, you might need more sample data to correctly
    # test your controllers. For example, when testing updating a student
    # your test object (student), will have to have been saved and you'll have
    # to compare the original student to the updated student and make sure the
    # correct updates occurred. Feel free to create more test objects as you need.

    # BONUS - Use factory_girl https://github.com/thoughtbot/factory_girl

    # For all the tests of the student index, we need the following:
    # 1. To stub out that the Student::all to return our test object student.
    #    This means that our controller tests for the index will not actually
    #    call the ::all method on Student, but rather, stub it out, or fake it.
    #    It's nice if you can isolate your controller tests from the database.
    #    However, feel free to never use something like should_receive and 
    #    just use as many real objects as you want.

    # 2. It creates a mock web request to the route '/' so that our tests
    #    can check the response to that request through the Rack::Test provided
    #    method 'last_response', which will always mean the last response
    #    our test suite triggered.
    before do
      Student.should_receive(:all).and_return([student])
      get '/'
    end

    # A good controller test you can write for every single route/action
    # is to make sure it responds with a 200 status code.
=begin
    it 'responds with a 200' do
      # We use the last_response object to test the properties of the response
      # sinatra would send to the request. last_response behaves a lot like an
      # HTTP, with methods to provide a status code and the body of the response
      # A shortcut to checking the status is to just say it is ok with the line below.
      expect(last_response).to be_ok
    end
  
    it 'has the students name in the response' do
      # The body of the last_response is basically the rendered HTML from the view.
      expect(last_response.body).to include(student.name)
    end
=end
  end

  # get form to create new student
  context 'GET /students/new' do
    it "should have text 'New Student'" do
      get "/students/new"
      last_response.body.should include('New Student')
    end
  end

  # create new student, saving all new student data
  context 'POST /students' do
    it 'accepts the form data and creates a student with those attributes' do
      post '/students', {name: "Miss Piggy2"}
      expect(Student[name: "Miss Piggy2"]).to be_a(Student)
    end
    it 'redirects to student page' do
      post '/students', {name: "Fozzie Bear"}
      expect(last_response).to be_redirect
      expect(last_response.location).to include('/upload/fozzie-bear')
    end
  end
  # show info for 1 student
  context 'GET /students/:slug' do
    it "should have student's name" do
      student.save
      get "/students/#{student.slug}"
      last_response.body.should include(student.name)
    end
  end
  # edit 1 specific student 
  # This context should only be about testing the edit form.
  context 'GET /students/:slug/edit' do
    before do
      student.save
      get "/students/#{student.slug}/edit"
    end
    it 'responds with a 200' do
      expect(last_response).to be_ok
    end
    it "should have student's name" do
      last_response.body.should include(student.name)
    end
  end
  # update (after editing 1 student)
  context "POST /students/:slug" do
    it "should change student's Twitter" do
      student = Student[name: "Miss Piggy2"]
      post "/students/miss-piggy2", {name: "Miss Piggy2", twitter: "Oink", linkedin: "OinkLinked", github: "OinkGitHub"}
      Student[name: "Miss Piggy2"].twitter.should eq("Oink")
    end
  end
  # delete a student
  context 'GET /students/:slug/destroy' do
    before do
      student.save
      get "/students/#{student.slug}/destroy"
    end
    it "should have student's name" do
      last_response.body.should_not include(student.name)
    end
  end
end