# -*- encoding: utf-8 -*-
# stub: fv 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fv"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "http://gems.focusvision.com" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["FocusVision"]
  s.bindir = "exe"
  s.date = "2019-05-08"
  s.description = "The fv gem provides common tools for creating FV SDKs"
  s.email = ["portlanddevelopers@focusvision.com"]
  s.files = [".rspec", "Gemfile", "Gemfile.lock", "README.md", "Rakefile", "bin/console", "bin/setup", "fv.gemspec", "lib/fv.rb", "lib/fv/api_resource.rb", "lib/fv/client.rb", "lib/fv/configuration.rb", "lib/fv/exceptions.rb", "lib/fv/has_many_association.rb", "lib/fv/http_client.rb", "lib/fv/http_response.rb", "lib/fv/url_param.rb", "lib/fv/version.rb", "test.sh"]
  s.homepage = "https://invent.focusvision.com/Portland/fv"
  s.rubygems_version = "2.4.5.2"
  s.summary = "Common FocusVision utilities"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["~> 0.14.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.11"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<pry-inline>, ["~> 1.0.2"])
      s.add_development_dependency(%q<webmock>, ["~> 2.3.1"])
    else
      s.add_dependency(%q<httparty>, ["~> 0.14.0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.11"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<pry-inline>, ["~> 1.0.2"])
      s.add_dependency(%q<webmock>, ["~> 2.3.1"])
    end
  else
    s.add_dependency(%q<httparty>, ["~> 0.14.0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.11"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<pry-inline>, ["~> 1.0.2"])
    s.add_dependency(%q<webmock>, ["~> 2.3.1"])
  end
end
