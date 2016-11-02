require 'sinatra'
require 'haml'
require 'pry'
require "sinatra/reloader" if development?
require_relative "app/filemanager.rb"

set :haml, format: :html5
enable(:sessions)

get '/' do
  return redirect to("/my_page") if session[:logged]
  erb(:index)
end

post '/crear_twit' do
  Filemanager.new_twit(session[:username],params[:message])
  redirect to ("/my_page")
end

before '/auth/*' do
  @user = params[:username]
  @pass = params[:password]
  @passwords = []
end

post "/auth/loggin" do
  if Filemanager.authenticate(@user,@pass)
    session[:logged] = true
    session[:username] = @user
    redirect to("/my_page")   
  else
    @error = "Invalid user or password"
    erb(:index)
  end
  
end

post "/auth/register" do
  
  if Filemanager.get_passwords.find {|user| user[0] == @user}
    @error = "User already exists"
    erb(:index)
  else
    Filemanager.register(@user,@pass)
    session[:logged] = true
    session[:username] = @user
    redirect to("/my_page")
  end 
end

get "/my_page" do
  return redirect to("/") unless session[:logged]
  @twits = Filemanager.get_twits(session[:username])
  erb(:main)
end

get "/logout" do
  session[:logged] = false
  redirect to("/")
end
