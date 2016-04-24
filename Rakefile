require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/extensiontask'

spec = Gem::Specification.load('blake2.gemspec')

Rake::ExtensionTask.new('blake2_ext', spec) do |ext|
  ext.source_pattern = '*.{c,h}'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
end

task default: :full

desc 'clean, compile, and run the full test suite'
task full: %w(clean compile test)
