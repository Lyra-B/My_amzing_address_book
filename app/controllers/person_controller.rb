

MyAmazingAddressBook::App.controllers :person do	
  get '/all' do
  	@people = Person.all
  	render '/people/all'
  	#@person = Person.find_by_first_name(params[:first_name])
  end

  get '/new' do
  	render 'people/form_page'
	end

	post '/create' do
		Person.create(params)
	  redirect "/person/#{params[:first_name]}"
	end

  get '/edit/:id' do
    #binding.pry
    @person = Person.find(params[:id])
    render '/people/edit'
  end

  post '/update/:id' do
    @person = Person.find(params[:id])
    @person.update(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email],:phone => params[:phone], :twitter => params[:twitter])
    redirect "/person/#{params[:first_name]}"
  end

  post '/delete/:id' do
    @person = Person.find(params[:id])
    @person.destroy
    redirect '/'
  end

  get '/:first_name' do 
  #this is not the homepage!It's '/person'
    @person = Person.find_by_first_name(params[:first_name])
    render '/people/person'
  end


end