require 'rubygems'
require 'trollop'
require File.join(File.dirname(__FILE__), '../lib/gistr')
include Gistr

SUBCOMMANDS = %w(list ls new n get g whoami h help)

def help(cmd='')
	
end

def list
	g = my_gists
	if g["gists"]
		g["gists"].each do |gist|
			line = "gist: #{gist[:repo]}"
			line += "\n" unless gist[:description]
			line += " -- #{gist[:description]}\n" if gist[:description]
			puts line
		end
		exit 0
	else
		puts "No gists found. Is git configured with your Github username?"
		exit 1
	end
end

def make_new(opts)
end

def get(opts)
end

def whoami
	puts `git config --global github.user`
	exit 0
end

global_options = Trollop::options do
	banner(DATA.read)
	stop_on SUBCOMMANDS
end

command = ARGV.shift

case command
when "ls", "list"
	run :list
when "g", "get"
	cmd_opts = Trollop::options do
		opt :clip, "Copy gist to the clipboard", :short => '-c'
	end
	get(cmd_opts)
when "n", "new"
	cmd_opts = Trollop::options do
		opt :clip, "Create gist from clipboard contents", :short => '-c'
		opt :filename, "The filename for your gist (for syntax highlighting)", :short => '-f'
		opt :description, "A short description of the gist", :short => '-d'
		opt :private, "Make this gist private", :short => '-p'
	end
	make_new(cmd_opts)
when "h", "help"
	help(ARGV.shift) unless ARGV.empty?
	help if ARGV.empty?
when "whoami"
	whoami
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

  ls, list
    Shows a list of all gists owned by you.

  n, new [-p, -f FILENAME, -d DESCRIPTION] [INPUT]
    Create a new gist with optional title and description attributes.
    If you specify the -p option and no input, Gistr will use the contents
    of the clipboard.
      -c, --clip (use contents of clipboard for input)
      -f, --filename FILENAME (give the gist the specified file name for syntax highlighting)
      -d, --description DESCRIPTION (a short description of the gist)
      -p, --private (make this gist private)