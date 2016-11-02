require 'sinatra'
require 'haml'
require 'pry'
require "sinatra/reloader" if development?

set :haml, format: :html5
enable(:sessions)

get '/' do
  return redirect to("/my_page") if session[:logged]
  erb(:index)
end

post '/crear_twit' do
  twits_file = File.open("private/#{session[:username]}.txt", "a")
  twits_file.puts("#{params[:message]}\n")
  twits_file.close
  redirect to ("/my_page")
end

post "/loggin" do
  @user = params[:username]
  @pass = params[:password]
  @passwords = []

  file = File.open("private/passwords.txt", "r")
  file.each_line do |line|
    @passwords.push(line.chomp.split(" "))
  end
  file.close  

  @passwords.each do |user|
    if user[0] == @user && user[1] == @pass
      session[:logged] = true
      session[:username] = @user
      redirect to("/my_page")
    end
  end
  session[:logged]= false
  redirect to("/")
end

post "/register" do
  @user = params[:username]
  @pass = params[:password]
  @passwords = []
  file = File.open("private/passwords.txt", "a")
  file.puts("#{@user} #{@pass}\n")
  file.close

  twits_file = File.open("private/#{@user}.txt", "a")
  twits_file.close
  
  session[:logged] = true
  session[:username] = @user
  redirect to("/my_page")
end

get "/my_page" do
  return redirect to("/") unless session[:logged]
  @twits = []
  twits_file = File.open("private/#{session[:username]}.txt", "r")
  twits_file.each_line do |line|
    @twits.push(line.chomp)
  end
  twits_file.close
  erb(:main)
end

get "/logout" do
  session[:logged] = false
  redirect to("/")
end
