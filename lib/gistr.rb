require 'yaml'
require 'net/http'
require 'uri'

module Gistr
	
	
	
	class Gist
		attr_accessor :content, :options, :name, :description
		def initialize(content, options={:filename => "gist.txt", :private => false, :description => nil})
			@content = content
			@options = options
			@name = @options[:filename]
			@private = @options[:private]
			@description = @options[:description]
		end
		
		def save
			url = URI.parse("http://gist.github.com/api/v1/yaml/new")
			files = { "files[#{@name}]" => @content }
			desc = @description ? {'description' => @description} : {}
			priv = @private ? {'private' => 'on'} : {}
			data = files.merge(desc).merge(priv).merge(auth)
			res = Net::HTTP.post_form(url, data)
			return YAML.load(res.body)
		end
		
		def private?
			@private
		end
		
		def auth
			user  = `git config --global github.user`.strip
			token = `git config --global github.token`.strip

			user.empty? ? {} : { :login => user, :token => token }
		end
	end
end