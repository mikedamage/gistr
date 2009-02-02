require 'rubygems'
require 'optparse'
require File.join(File.dirname(__FILE__), '../lib/gistr')

SUBCOMMANDS = %w(list new get)
opts = OptionParser.new do |opt|
	opt.banner = <<EOF
Gistr
command line gist client for os x
-------------------------------------
Usage: gistr [-chvp] action [INPUT]

Commands:
	get GIST_ID - Gets specified Gist

Options:
EOF
	opt.on('-c', '--clipboard', "Use the OS X clipboard as input source or output destination, depending on operation.") do
		clipboard = true
	end
end

opts.parse!(ARGV)


