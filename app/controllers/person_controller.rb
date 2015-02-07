require 'pry'

MyAmazingAddressBook::App.controllers :person do	


  get :homepage, :map => '' do
    render :homepage
  end

  get :sign_up, :map => 'person/sign_up' do
    @user = User.new
    flash[:notice]
    render :'people/user_new'
  end

  post :sign_up do
    @user = User.new(params[:user])
    @user.save
    flash[:notice] = "Signing up successful. Now please login!"
    redirect '/person/login'
  end

  get :login do
    @user = User.new
    flash[:notice]
    render :'/people/login'
  end

  post :login do
    #binding.pry
    @user = User.find_by_username(params[:user][:username])
    #binding.pry
    if @user && params[:user][:password] == @user.password
      session[:logged_in] = true
      flash[:notice] = "You are successfully logged in"
      redirect 'person/all'
    else
      flash[:notice] = "Username or password wrong.Try again!"
      redirect '/person/login'
    end
  end

  get :users_all do
    @users = User.all
    render :'people/all_users'
  end

  get :all do
  	@people = Person.all
  	render :'people/all' #'/people/all'
  end

  get :new do
    @person = Person.new
  	render :'people/form_page'
	end

  post :add_fields, :map => '/person/add_fields' do
    @person = Person.new(params[:person])
    #binding.pry
    render :'people/type'
    # if @person.type == 'Trainee'
    #   render :'people/trainee_form'
    # elsif @person.type == 'Instructor'
    #   render :'people/instructor_form'
    # end
  end

	post :create, :map => '' do
    #binding.pry

		@person = Person.new(params[:trainee] || params[:instructor])
    @person.save
	  redirect "/person/#{@person.id}"
	end

 

  # put :add_fields, :map => '' do
  #   @person = Person.new(params[:person])
  #   @person.save
  #   redirect "/person/#{@person.id}"
  # end

  get :edit, :map => 'person/:id/edit' do
    @person = Person.find(params[:id])
    render :'people/edit'
  end

  put :update, :map => 'person/:id' do
    @person = Person.find(params[:id])
    @person.update(params[:person])
    redirect "/person/#{@person.id}"
  end

  delete :delete, :map => 'person/:id' do
    @person = Person.find(params[:id])
    @person.destroy
    redirect '/'
  end


  get :show, :map => 'person/:id' do 
    @person = Person.find(params[:id])
    render :'people/person'
  end
end