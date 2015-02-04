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
	  @person = Person.create(:first_name => "Glykeria")
	  @person_two = Person.create(:first_name => "Dan")
	  assert_equal 2,Person.count
	  get '/person/all' 
	  assert last_response.ok?
	  #binding.pry
	  last_response.body.must_match(/Dan/)
	  last_response.body.must_match(/Glykeria/) 
  end

  it 'should show an individual person in the addressbook' do
  	@person = Person.create(:first_name => "Glykeria")
  	get '/person/Glykeria' 
  	 #binding.pry
  	assert last_response.ok?
  	last_response.body.must_match(/Glykeria/)
  end

  it "should create a form page" do
    get '/person/new'
    assert_equal last_response.ok?
  end



  after do
    DatabaseCleaner.clean
  end


end
