require 'io/console'
require 'net/ssh'
require 'rake/clean'
host = 'cuihq.me'
path = 'blog'

CLEAN.include('log/*.log')
CLOBBER.include('views/*.md')

task :default => :new

desc 'create a new article.'
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
  puts "\n===deploy begin==="
  Net::SSH.start(host, user, :password => password) do |ssh|
    puts "\nstop server:"
    puts ssh.exec!('god stop')
    puts "\nupdate code from github:"
    puts ssh.exec!("[ -d #{path} ] && cd #{path} && git pull || git clone http://github.com/cuihq/blog")
    puts "\nstart server:"
    puts ssh.exec!('god start')
  end
  puts "\n===deploy finished==="
end
