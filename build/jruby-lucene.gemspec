require 'lib/jruby/lucene'


Gem::Specification.new do |s|

  s.name = 'jruby-lucene'
  s.version = Lucene::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    A jruby interface to the native java lucene library
  DESC

  s.files = Dir.glob("{lib,test,ext}/**/*") + %w(README)
  s.require_path = 'lib'
  s.has_rdoc = true

  s.authors = ["Mark Watson", "David Andersen"]
  s.email = ["mark.watson@gmail.com", "davidx@gmail.com"]
  s.homepage = "http://github.com/davidx/jruby-lucene/tree"
  s.rubyforge_project = "jruby-lucene"

end
