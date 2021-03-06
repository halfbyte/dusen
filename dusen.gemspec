$:.push File.expand_path("../lib", __FILE__)
require "dusen/version"

Gem::Specification.new do |s|
  s.name = 'dusen'
  s.version = Dusen::VERSION
  s.authors = ["Henning Koch"]
  s.email = 'henning.koch@makandra.de'
  s.homepage = 'https://github.com/makandra/dusen'
  s.summary = 'Comprehensive full text search for ActiveRecord and MySQL'
  s.description = s.summary
  s.license = 'MIT'

  s.files         = `git ls-files`.split("\n").reject { |path| File.lstat(path).symlink? }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n").reject { |path| File.lstat(path).symlink? }
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activerecord', '>= 3.0', '< 5')
  s.add_dependency('edge_rider', '>=0.2.5')

end
