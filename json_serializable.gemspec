# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "json_serializable/version"

Gem::Specification.new do |s|
  s.name        = "json_serializable"
  s.version     = JsonSerializable::VERSION
  s.authors     = ["smsohan"]
  s.email       = ["sohan39@gmail.com"]
  s.homepage    = "https://github.com/smsohan/json_serializer"
  s.summary     = %q{Provides a clean approach to custom JSON serialize your AR models}
  s.description = %q{Use custom names in JSON keys and your custom logic in JSON values}

  s.rubyforge_project = "json_serializable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
