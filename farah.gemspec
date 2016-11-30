require_relative './lib/farah/version'

Gem::Specification.new do |s|
  s.name     = 'farah'
  s.summary  = 'Farah'
  s.version  = Farah::VERSION
  s.authors  = ['Steve Weiss']
  s.email    = ['weissst@mail.gvsu.edu']
  s.homepage = 'https://github.com/sirscriptalot/farah'
  s.license  = 'MIT'
  s.files    = `git ls-files`.split("\n")
end
