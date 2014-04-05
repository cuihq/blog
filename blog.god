God.watch do |w|
  w.name = 'blog'
  w.start = 'ruby app.rb'

  w.log = 'log/server.log'
  w.dir = File.dirname(__FILE__)

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.interval = 20.seconds
      c.above = 50.megabytes
      c.times = [3, 5]
    end

    restart.condition(:cpu_usage) do |c|
      c.interval = 10.seconds
      c.above = 60.percent
      c.times = 5
    end
  end

   w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 2
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 2
      c.retry_within = 2.hours
    end
  end
end