require 'sinatra'
require 'haml'
require 'pry'
require "sinatra/reloader" if development?

set :haml, format: :html5
enable(:sessions)

get '/' do
  #Si está logeado que empiece en su página
  if session[:logged] == true

    redirect to("/my_page")
  else
    erb(:index)
  end
  
end

post '/crear_twit' do
  twits_file = File.open("private/#{session[:user]}.txt", "a")
  twits_file.puts("#{params[:message]}\n")
  twits_file.close
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

    twits_file = File.open("private/#{@user}.txt", "a")
    twits_file.close
    
    session[:logged] = true
    session[:user] = @user
    redirect to("/my_page")
  end  
end


get "/my_page" do
  @twits = []
  twits_file = File.open("private/#{session[:user]}.txt", "r")
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
