require 'pry'

MyAmazingAddressBook::App.controllers :person do	
  # before do
  #   unless session[:logged_in] || request.path.start_with('/login')
  #     flash[:notice] = "Username or password wrong.Try again!"
  #     redirect '/login'
  #   end
  # end

  # get '/login' do
  #   flash[:notice]
  # end

  # post '/login' do
  #   @user = User.find_by_username[params[:username]]
  #   if @user && [params[:password]] == @user[:password]
  #     session[:logged_in] = true
  #   else
  #     flash[:notice] = "Username or password wrong.Try again!"
  #     redirect '/login'
  #   end
  # end

  get '/all' do
  	@people = Person.all
  	render '/people/all'
  end

  get '/new' do
    @person = Person.new
  	render 'people/form_page'
	end

	post '/create' do
    #binding.pry
		@person = Person.create(params[:person])
    #binding.pry
    @person.save!
    #binding.pry
	  redirect "/person/#{@person.first_name}"
   # flash[:notice] = "Person #{@person.first_name} "
	end

  get '/edit/:id' do
    #binding.pry
    @person = Person.find(params[:id])
    #binding.pry
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
    @person = Person.find_by_first_name(params[:first_name])
    render '/people/person'
  end


end