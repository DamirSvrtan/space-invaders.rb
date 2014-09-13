# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "space_invaders"
  spec.version       = "0.0.4"
  spec.authors       = ["Damir Svrtan"]
  spec.email         = ["damir.svrtan@gmail.com"]
  spec.summary       = "space_invaders.rb"
  spec.description   = "Classic arcade game written in Ruby w/ Gosu."
  spec.homepage      = "https://github.com/DamirSvrtan/space-invaders.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'space-invaders'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_dependency "gosu"
end
