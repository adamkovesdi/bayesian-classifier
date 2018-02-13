require 'classifier-reborn'
require_relative 'feedbrain'

def readline
  print '> '
  rv = $stdin.gets
  rv || 'quit'
end

def init
  print 'Initializing: '
  b = Feedbrain.fill
  puts "\nBrain initialization complete"
  b
end

def getcategories(b, input)
  h = b.classifications(input)
  scores = h.sort_by { |_k, v| v }.reverse[0..2].join(' ')
  winner = h.max_by { |_k, v| v }[0]
  "#{winner} [#{scores}]"
end

def interactive
  b = init
  puts 'Let me try to categorize your sentence (type quit or Ctrl+D to exit)'
  loop do
    input = readline.chomp
    break if input == 'quit'
    next if input == ''
    # main logic goes here
    puts getcategories(b, input)
  end
end

interactive
