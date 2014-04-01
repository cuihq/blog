$:.unshift File.dirname(__FILE__)
require 'net/ssh'
require 'io/console'
host = 'cuihq.me'
path = './blog'

task :default => :new

desc 'Create a new article.'
task :new do
  print 'Title: '
  title = STDIN.gets.chomp.gsub(/\s+/, '_')
  title = 'untitle' if title.empty?
  if File.exist? "views/#{title}.md"
    puts "\n sorry, #{title} already exists.\n\n"
  else
    File.open("views/#{title}.md", "w") { |file| file.write "Once upon a time...\n\n" }
    puts "\n #{title} was created for you.\n\n"    
  end
end

desc 'deploy to server'
task :deploy do
  print 'UserName:'
  user = STDIN.gets.chomp
  user = 'root' if user.empty?
  print 'Password:'
  password = STDIN.noecho(&:gets).chomp
  puts "\n deploy beginning...\n\n"
  Net::SSH.start(host, user, :password => password) do |ssh|
    ssh.exec!("cd #{path}")
    puts ssh.exec!("pwd")
  end
  puts "\n deploy finished. \n\n"
end