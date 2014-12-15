require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative './models/user'
# require_relative './models/meal'
require_relative './config/environments'

enable :sessions

helpers do
  def current_user
    @current_user || nil
  end

  def current_user?
    @current_user == nil ? false : true
  end
end

before do
  @errors ||= []
  @current_user = User.find_by(:id => session[:user_id])
end

get '/' do 
	erb :index
end

get "/users" do
  if current_user?
    erb :profile
  else
    redirect('/login')
  end
end

get '/login' do
  erb :login
end

post "/login" do
  user = User.find_by(:email => params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect('/users')
  else
    @errors << "Invalid email or password. Try again!"
    erb :login
  end
end

get '/signup' do
	erb :signup
end

post '/signup' do
  user = User.new(name: params["name"], phonenumber: params["phonenumber"], email: params["email"], password: params["password"])
  if user.save
    session[:user_id] = user.id
    id = user.id
    redirect('/users')
  else
    @user = user
    erb :signup
  end
end

post '/login' do
  @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect("/users")  
    else
      @errors << "incorrect password or email"
      erb :login
    end
end

get "/logout" do
  session.clear
  redirect('/')
end