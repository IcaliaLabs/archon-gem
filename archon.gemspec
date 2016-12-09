# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'archon/version'

Gem::Specification.new do |spec|
  spec.name          = "archon"
  spec.version       = Archon::VERSION
  spec.authors       = ["Roberto Quintanilla"]
  spec.email         = ["vov@icalialabs.com"]

  spec.summary       = %q{ARchon: Summoning the powers of ActiveRecord and ARel to wreak havoc}
  spec.description   = %q{A collection of methods and classes that unleash the power of the database :D}
  spec.homepage      = "https://github.com/IcaliaLabs/archon-gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  all_things_rails_version_string = ['>= 4.2']
  spec.add_runtime_dependency %q<activerecord>, all_things_rails_version_string

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
end
