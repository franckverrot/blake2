# coding: utf-8
Gem::Specification.new do |spec|
  spec.name     = "blake2"
  spec.version  = "1.0.0"
  spec.authors  = ["Franck Verrot"]
  spec.email    = ["franck@verrot.fr"]
  spec.homepage = "https://github.com/franckverrot/blake2"
  spec.license  = "MIT"

  spec.summary     = "BLAKE2 - fast secure hashing - for Ruby"
  spec.required_ruby_version = ">= 2.1.0"
  spec.description = "BLAKE2 is a C-extension for using BLAKE2s in Ruby"
  spec.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir      = "bin"

  spec.extensions << "ext/blake2_ext/extconf.rb"

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake-compiler", "~> 0.9"
  spec.add_development_dependency "bundler"      , "~> 1.5"
  spec.add_development_dependency "rake"         , "~> 11.1"
  spec.add_development_dependency "minitest"     , "~> 5.8"
  spec.add_development_dependency "pry"          , "~> 0.10"

  spec.cert_chain  = ['certs/franckverrot.pem']
  spec.signing_key = File.expand_path(ENV['RUBYGEMS_CERT_PATH']) if $0 =~ /gem\z/
end
