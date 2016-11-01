require 'sinatra'
require 'haml'
require 'pry'
require "sinatra/reloader" if development?

set :haml, format: :html5
enable(:sessions)

get '/' do
  @msg = "invalid user or passsword"
  session[:twits] ||= []
  erb(:index)
end

post '/crear_twit' do
  session[:twits].push(params[:message])
  redirect to ("/my_page")
end

post '/register_or_loggin' do

  @user = params[:user]
  @pass = params[:pass]
  @action = params[:action]

  @passwords = []
  file = File.open("private/passwords.txt", "r")
  file.each_line do |line|
    @passwords.push(line.chomp.split(" "))
  end
  file.close  

  if @action == "loggin"
    @passwords.each do |user|
      if user[0] == @user && user[1] == @pass
        session[:logged] = true
        session[:user] = @user
        redirect to("/my_page")
      end
    end
    session[:logged]= false
    redirect to("/")
  else
    file = File.open("private/passwords.txt", "a")
    file.puts("#{@user} #{@pass}\n")
    file.close
    session[:logged] = true
    session[:user] = @user
    redirect to("/my_page")
    #Recorrer el txt para ver si ya esta el usuario?
  end
  
end


get "/my_page" do
  erb(:main)
end


