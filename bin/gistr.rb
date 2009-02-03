require 'rubygems'
require 'trollop'
require File.join(File.dirname(__FILE__), '../lib/gistr')
include Gistr

SUBCOMMANDS = %w(list ls new n get g whoami h help)

global_options = Trollop::options do
	banner(DATA.read)
	stop_on SUBCOMMANDS
end

command = ARGV.shift

case command
when "ls", "list"
	g = my_gists
	if g["gists"]
		g["gists"].each do |gist|
			line = "gist: #{gist[:repo]}"
			line += "\n" unless gist[:description]
			line += " -- #{gist[:description]}\n" if gist[:description]
			puts line
		end
	else
		puts "No gists found. Is git configured with your Github username?"
		exit 1
	end
when "g", "get"
	cmd_opts = Trollop::options do
		
	end
when "n", "new"
	cmd_opts = Trollop::options do
		
	end
when "h", "help"
	# display a help message
when "whoami"
	puts `git config --global github.user`
	exit 0
end



__END__
Gistr
Command Line Gist Client for OS X
by Mike Green <mike.is.green@gmail.com>
http://mikedamage.github.com/gistr
-------------------------------------------

Usage: gistr <command> [options] [INPUT]

Commands:
  g, get [-c] <id>
    Gets the gist with the specified ID.
      -c, --clip (copy output to clipboard)

  h, help <command>
    Displays usage information for a specific command.

  l, list
    Shows a list of all gists owned by you.

  n, new [-p, -f FILENAME, -d DESCRIPTION] [INPUT]
    Create a new gist with optional title and description attributes.
    If you specify the -p option and no input, Gistr will use the contents
    of the clipboard.
      -p, --paste (use contents of clipboard for input)
      -f, --filename FILENAME (give the gist the specified file name for syntax highlighting)
      -d, --description DESCRIPTION (a short description of the gist)