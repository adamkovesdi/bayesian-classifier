guard :shell do
  watch(/(.*).rb/) do |m|
	puts m.to_enum
	puts "\n\n"
	puts '-------------------------------'
	puts ' ' + Time.now.to_s
	puts ' Running static code analyisis'
	puts '-------------------------------'
	`rubocop --color #{m[0]}`
	end
end
