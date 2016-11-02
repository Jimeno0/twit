class Filemanager

  def self.new_twit(user,msg)
    twits_file = File.open("private/#{user}.txt", "a")
    twits_file.puts("#{msg}\n")
    twits_file.close
  end

  def self.authenticate(username,password)
    self.get_passwords.each do |user|
      return true if user[0] == username && user[1] == password
    end
    false
  end

  def self.register(username,password)
    file = File.open("private/passwords.txt", "a")
    file.puts("#{username} #{password}\n")
    file.close
    twits_file = File.open("private/#{username}.txt", "a")
    twits_file.close
  end

  def self.get_twits(username)
    twits = []
    twits_file = File.open("private/#{username}.txt", "r")
    twits_file.each_line do |line|
      twits.push(line.chomp)
    end
    twits_file.close
    twits
  end

  def self.get_passwords
    file = File.open("private/passwords.txt", "r")
    passwords = []
    file.each_line do |line|
      passwords.push(line.chomp.split(" "))
    end
    file.close
    passwords 
  end
  
end