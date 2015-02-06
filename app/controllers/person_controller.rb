require 'pry'

MyAmazingAddressBook::App.controllers :person do	

  get :all do
  	@people = Person.all
  	render :all #'/people/all'
  end

  get :new do
    @person = Person.new
  	render :form_page
	end

	post :create, :map => '' do
		@person = Person.new(params[:person])
    @person.save
	  redirect "/person/#{@person.id}"
    #flash[:notice] = "Person #{@person.first_name} "
	end

  get :edit, :map => 'person/:id/edit' do
    #binding.pry
    @person = Person.find(params[:id])
    #binding.pry
    render :edit
  end

  put :update, :map => 'person/:id' do
    #binding.pry
    @person = Person.find(params[:id])
    #binding.pry
    @person.update(params[:person])
    #(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email],:phone => params[:phone], :twitter => params[:twitter])
    #binding.pry
    redirect "/person/#{@person.id}"
  end

  delete :delete, :map => 'person/:id' do
    @person = Person.find(params[:id])
    @person.destroy
    redirect '/'
  end

  # get :login do
  #   @user = User.new
  #   flash[:notice]
  #   erb :login
  # end

  # post :login do
  #   @user = User.find_by_username[params[:username]]
  #   if @user && [params[:password]] == @user[:password]
  #     session[:logged_in] = true
  #   else
  #     flash[:notice] = "Username or password wrong.Try again!"
  #     redirect 'person/login'
  #   end
  # end

  get '/:id' do 
    @person = Person.find(params[:id])
    render :person
  end

  # before do
  #   unless session[:logged_in] # || request.path.start_with('/login')
  #     flash[:notice] = "Username or password wrong.Try again!"
  #     redirect '/login'
  #   end
  # end
  # get '/user/new' do
  #   @user = User.new
  #   render :user_new
  # end

  # # get '/new' do
  # #   @person = Person.new
  # #   render :form_page
  # # end

  # post '/user/create' do
  #   @person = Person.new(params[:user])
  #   @person.save
  #   redirect "/person/user/login"
  #  # flash[:notice] = "Person #{@person.first_name} "
  # end


  # post '/login' do
  #   @user = User.find_by_username[params[:username]]
  #   if @user && [params[:password]] == @user[:password]
  #     session[:logged_in] = true
  #   else
  #     flash[:notice] = "Username or password wrong.Try again!"
  #     redirect 'person/login'
  #   end
  # end
end