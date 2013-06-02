require 'rdoc/task'
require 'rake/clean'
require 'rake/testtask'
require 'bundler/gem_tasks'

RDoc::Task.new

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
end

task default: :test
