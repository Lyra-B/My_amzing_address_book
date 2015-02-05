require 'pry'
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation


describe "User Model" do
  before do
    DatabaseCleaner.start
  end

  it 'can create a new instance' do
    @user = User.new
    refute_nil @user
  end

  after do
    DatabaseCleaner.clean
  end
end