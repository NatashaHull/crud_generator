require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = 'crud_generator'
  s.version = '0.0.0'
  s.summary = "CRUD generator generates CRUD dynamically in controllers"
  s.files = Dir.glob("**/**/**")
  s.test_files  = Dir.glob("{spec,test}/**/*.rb")
  s.auto_require = 'crud_generator'
  s.add_development_dependency 'rspec', '~> 2.5'
  s.add_development_dependency'active_support/inflector'

  s.author = "Natasha Hull-Richter"
  s.email = "natashaalex.hull@gmail.com"

end