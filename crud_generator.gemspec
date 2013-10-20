require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = 'crud_generator'
  s.version = '0.0.1'
  s.summary = "CRUD generator generates CRUD dynamically in controllers"
  s.description = s.summary
  s.homepage    = 'http://github.com/NatashaHull/crud_generator'
  s.files = Dir.glob("lib/**/**")
  s.test_files  = Dir.glob("{spec,test}/**/*.rb")
  s.autorequire = 'crud_generator'
  s.add_development_dependency 'rspec'
  s.add_development_dependency'active_support/inflector'

  s.author = "Natasha Hull-Richter"
  s.email = "natashaalex.hull@gmail.com"

end