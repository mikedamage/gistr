class Gist
	
	include Gistr
	attr_accessor :content, :options, :name, :description
	
	def initialize(content, options={:filename => "gist.txt", :private => false, :description => nil})
		@content = content
		@options = options
		@name = @options[:filename]
		@private = @options[:private]
		@description = @options[:description]
	end
	
	def save
		url = URI.parse($base_uri + '/new')
		files = { "files[#{@name}]" => @content }
		desc = @description ? {'description' => @description} : {}
		priv = @private ? {'private' => 'on'} : {}
		data = files.merge(desc).merge(priv).merge(auth)
		res = Net::HTTP.post_form(url, data)
		return YAML.load(res.body)
	end
	
end