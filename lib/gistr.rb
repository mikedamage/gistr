require 'yaml'
require 'net/http'
require 'uri'
require 'pathname'

module Gistr
	$base_uri = 'http://gist.github.com/api/v1/yaml'
	
	def copy(content)
		IO.popen('pbcopy', 'r+') {|clipboard| clipboard.write(content) }
	end
	
	def paste
		IO.popen('pbpaste', 'r') {|clipboard| clipboard.read }
	end
	
	def auth
		user  = `git config --global github.user`.strip
		token = `git config --global github.token`.strip

		user.empty? ? {} : { :login => user, :token => token }
	end
	
	def new_from_clipboard(*args)
		content = paste
		name 	= args[0] if args.size > 0
		pvt 	= args[1] if args.size >= 2
		desc 	= args[2] if args.size >= 3
		name 	||= "gist.txt"
		pvt 	||= false
		desc 	||= nil
		gist = Gist.new(content, :filename => name, :private => pvt, :description => desc)
		response = gist.save
		gist_url = "http://gist.github.com/" + response['gists'][0][:repo]
		copy gist_url
		gist_url
	end
	
	def my_gists
		if auth[:login]
			user = auth[:login]
			url = URI.parse($base_uri + '/gists/' + user)
			res = Net::HTTP.start(url.host, url.port) {|http| http.get(url.path) }
			if res.is_a?(Net::HTTPOK)
				return YAML.load(res.body)
			else
				return false
			end
		else
			return false
		end
	end
	
	def get_gist(id)
		url = URI.parse("http://gist.github.com/" + id.to_s + ".txt")
		res = Net::HTTP.start(url.host, url.port) {|http| http.get(url.path) }
		res.body
	end

end

Pathname.new(File.dirname(__FILE__)).children.reverse.each do |file|
	require file.to_s unless file.basename.to_s == __FILE__
end