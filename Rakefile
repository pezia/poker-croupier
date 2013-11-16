require 'rspec/core/rake_task'


desc "Run test suite (all RSpec examples and Cucumber features)"
task :test => [:'test:spec']

desc "Run RSpec code examples (options: RSPEC_SEED=seed)"
task :spec => :'test:spec'

desc "Runs the thrift compiler to refresh generated code of service end points"
task :thrift do
  ruby "rake/thrift_compiler.rb"
end

namespace :test do

  desc "Run RSpec code examples (options: RSPEC_SEED=seed)"
  RSpec::Core::RakeTask.new :spec do |task|
    task.pattern = './*/spec{,/*/**}/*_spec.rb'
    task.verbose = false
    task.rspec_opts = "--order random"
    task.rspec_opts = "--color"
    task.rspec_opts = "--format documentation"
    task.rspec_opts << " --seed #{ENV['RSPEC_SEED']}" if ENV['RSPEC_SEED']
  end

end
