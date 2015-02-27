require 'pry'
require 'active_support'

MyAmazingAddressBook::App.controllers :person do
  #Action Controller Overview '#8'
  before :except => :homepage do
    def require_login
      unless session[:logged_in] || request.path.include?('/login') || request.path.include?('/sign_up')
        # binding.pry
        flash[:notice] = "You must be logged in to access this section"
        redirect '/person'
      end
    end
    require_login
  end


  get :homepage, :map => '' do
    flash[:notice]
    render :'people/homepage'
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
    @user = User.find_by_username(params[:user][:username])
    if @user && params[:user][:password] == @user.password
      session[:logged_in] = true
      flash[:notice] = "You are successfully logged in"
      redirect 'person/index'
    else
      session[:logged_in] = false
      flash[:notice] = "Username or password wrong.Try again!"
      redirect '/person/login'
    end
  end

  get :index , :map => 'person/index' do
    @user = User.new
    flash[:notice]
    render :'people/menu'
  end

  # get :users_all do
  #   @users = User.all
  #   render :'people/all_users'
  # end

  get :all do
  	@people = Person.all
  	render :'people/all'
  end

  get :new do
    @person = Person.new
  	render :'people/form_page'
	end

  post :add_fields, :map => '/person/add_fields' do
    @person = Person.new(params[:person])
    render :'people/type'
  end

	post :create, :map => '' do
		@person = Person.new(params[:trainee] || params[:instructor])
    @person.save
	  redirect "/person/#{@person.id}"
	end

  get :edit, :map => 'person/:id/edit' do
    @person = Person.find(params[:id])
    render :'people/edit'
  end

  put :update, :map => 'person/:id' do
    @person = Person.find(params[:id])
    @person.update(params[:trainee] || params[:instructor])
    redirect "/person/#{@person.id}"
  end

  get :show, :map => 'person/:id' do
    @person = Person.find(params[:id])
    render :'people/person'
  end

  get :lastname, :map => 'person/lastname/:letter' do
    @people = Person.where("last_name LIKE '#{params[:letter]}%'")
    if @people.blank?
      flash[:notice] = "No matches!"
      redirect 'person/index'
    end
    render :'people/find_by_lastname'
  end

  delete :destroy, :map => 'person/:id' do
    @person = Person.find(params[:id])
    @person.destroy
    redirect 'person/index'
  end
end



