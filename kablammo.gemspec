# -*- encoding: utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__) + "/lib"

Gem::Specification.new do |s|
  s.name        = "kablammo"
  s.version     = "0.1"
  s.authors     = ["Michael Wynholds"]
  s.email       = ["mike@carbonfive.com"]
  s.homepage    = ""
  s.summary     = %q{Strategy gem for Kablammo robo wars}
  s.description = %q{Strategy gem for Kablammo robo wars}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'multi_json'
  s.add_runtime_dependency 'oj'
  s.add_runtime_dependency 'execjs', '1.4.0'
  s.add_runtime_dependency 'redis_message_capsule', '~>0.8.3'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
