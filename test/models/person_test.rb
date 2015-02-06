require 'pry'
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation


describe "Person Model" do
  before do
    DatabaseCleaner.start
  end

  it 'can construct a new instance' do
    @person = Person.new
    refute_nil @person
  end

  it 'should show all the people in the addressbook' do
	  @person = Person.create(:first_name => "Glykeria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com")
	  @person_two = Person.create(:first_name => "Dan", :last_name => "Steele", :twitter => "@dansteele", :phone => '34567890986', :email => "dansteele@email.com")
	  assert_equal 2,Person.count
	  get '/person/all' 
	  assert last_response.ok?
	  #binding.pry
	  last_response.body.must_match(/Dan/)
	  last_response.body.must_match(/Glykeria/) 
  end

  it 'should show an individual person in the addressbook' do
  	@person = Person.create(:id => 1, :first_name => "Glykeria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com")
  	get '/person/1' 
  	 #binding.pry
  	assert last_response.ok?
  	last_response.body.must_match(/Glykeria/)
  end

  it "should create a form page" do
    get '/person/new'
    assert last_response.ok?
  end

  it "should create a new person" do
    assert_equal 0, Person.count
    post '/person', {:first_name => "Glykeria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com" }
    assert_equal 1, Person.count
  end

  it "should edit an existing person" do
    Person.create(:first_name => "Glykeria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com")
    get '/person/1/edit'
    assert last_response.ok?
  end

  it "should update the person" do
    Person.create(:first_name => "Glykeria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com")
    assert_equal 1, Person.count
    put '/person/1', {:first_name => "Maria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com"}
    assert_equal "Maria", Person.find(1).first_name
  end

  it "should delete a person" do
    Person.create(:first_name => "Glykeria", :last_name => "Peppa", :twitter => "@glykeriape", :phone => '12345677788', :email => "glykeriapeppa@gmail.com")
    assert_equal 1, Person.count
    delete 'person/1'
    assert_equal 0, Person.count
  end



  after do
    DatabaseCleaner.clean
  end


end
