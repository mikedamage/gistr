# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gistr}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Green"]
  s.date = %q{2009-02-03}
  s.description = %q{Command line client for Github Gists, built for Mac OS X.}
  s.email = %q{mike.is.green@gmail.com}
  s.files = ["README.rdoc", "VERSION.yml", "bin/gistr.rb", "lib/gist.rb", "lib/gistr.rb", "test/gistr_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mikedamage/gistr}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Command line client for Github Gists, built for Mac OS X.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
