require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative './models/user'
require_relative './models/meal'
require_relative './models/greeting'
require_relative './models/can'
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

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.new(name: params["name"], phonenumber: params["phonenumber"], 
    email: params["email"], password: params["password"])
  if user.save
    session[:user_id] = user.id
    id = user.id
    redirect('/profile')
  else
    @user = user
    erb :signup
  end
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(:email => params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect('/profile')
  else
    @errors << "Invalid email or password. Try again!"
    erb :login
  end
end

get '/profile' do
  @user_meals = Meal.where(user_id: session[:user_id])
  @user_cans = Can.where(user_id: session[:user_id])
  @user_greetings = Greeting.where(user_id: session[:user_id])
    if current_user?
      erb :profile
    else
      redirect('/login')
    end
end

post '/profile' do
  meal = Meal.create(name: params["name"], will_feed: params["will_feed"], 
    pickup_time: params["pickup_time"], pickup_location: params["pickup_location"])
    redirect('/thankyou')
end 

get '/cannedfood/create' do
  erb :create_canned
end 

post '/cannedfood/create' do
  can = Can.create(num_cans: params["num_cans"], container: params["container"], 
  pickup_time: params["pickup_time"], pickup_location: params["pickup_location"])
  redirect('/profile/thankyou')
end

get '/cannedfood/update/:can_id' do
  @can_id = params[:can_id]
  @can = Can.find_by(id: params["can_id"])
  erb :update_canned
end

put 'cannedfood/update/:can_id' do
  @can = Can.find_by(id: params["can_id"])
  if @can.user_id == session[:user_id]
        @can.num_cans = params[:num_cans]
        @can.container = params[:container]
        @can.pickup_time = params[:pickup_time]
        @can.pickup_location = params[:pickup_location]
        @can.save
        redirect('/profile/thankyou')
  else
    @errors << "You gotta be signed in to edit a post."
    redirect('/')
  end
end

get '/cannedfood/delete/:can_id' do
  @can_id = params[:can_id]
  @post = Post.find_by(id: params["can_id"])
  erb :delete_canned
end

get '/greeting/create' do
  if current_user?
    erb :greeting
  else
    redirect('/login')
  end
end 

post '/greeting/create' do
  greeting = Greeting.create(body: params["body"])
  redirect('/profile/thankyou')
end 

get '/profile/thankyou' do
  if current_user?
    erb :profty
  else
    redirect('/login')
  end
end

get '/thankyou' do
  if current_user?
    erb :thankyou
  else
    redirect('/login')
  end
end 

get "/logout" do
  session.clear
  redirect('/')
end