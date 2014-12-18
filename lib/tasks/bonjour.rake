task :echo, :message do |t, args|
  message = args[:message] || 'Hello'
  puts message
end