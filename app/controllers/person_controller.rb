MyAmazingAddressBook::App.controllers :person do	
  get '/all' do
  	@people = Person.all
  	render '/people/all'
  	#@person = Person.find_by_first_name(params[:first_name])
  end

  get '/new' do
  	render '/form_page'
	end

	# post '/'

	get '/:first_name' do 
	#this is not the homepage!It's '/person'
		@person = Person.find_by_first_name(params[:first_name])
    render '/people/person'
	end
end