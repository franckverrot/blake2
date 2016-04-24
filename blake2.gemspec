# coding: utf-8
Gem::Specification.new do |spec|
  spec.name     = "blake2"
  spec.version  = "0.2.0"
  spec.authors  = ["Franck Verrot"]
  spec.email    = ["franck@verrot.fr"]
  spec.homepage = "https://github.com/franckverrot/blake2"
  spec.license  = "GPLv3"

  spec.summary     = "BLAKE2 - fast secure hashing - for Ruby"
  spec.required_ruby_version = ">= 2.1.0"
  spec.description = spec.summary
  spec.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir      = "bin"

  spec.extensions << "ext/blake2_ext/extconf.rb"

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry", "~> 0.10"

  spec.cert_chain  = ['certs/franckverrot.pem']
  spec.signing_key = File.expand_path(ENV['RUBYGEMS_CERT_PATH']) if $0 =~ /gem\z/
end
