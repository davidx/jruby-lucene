
require 'rubygems'
require 'rake'
JRUBY_HOME=ENV['JRUBY_HOME']||'/usr/local/jruby'

task :build do
 print `#{JRUBY_HOME}/bin/gem build build/jruby-lucene.gemspec`
end

task :test do
  print `jruby -v test/test_all.rb`
end
