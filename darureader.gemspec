# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'darureader/version'

Gem::Specification.new do |spec|
  spec.name          = "darureader"
  spec.version       = Darureader::VERSION
  spec.authors       = ["jeyaraj"]
  spec.email         = ["jeyaraj.durairaj@gmail.com"]

  spec.summary       = %q{Reads xlsx file or MongoDB collection and returns Daru::DataFrame object.}
  spec.description   = %q{Helps have Daru::DataFrame object from Excel (xlsx) and MongoDB.}
  spec.homepage      = "https://github.com/jeydurai/darureader"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
    #raise "RubyGems 2.0 or newer is required to protect against " \
      #"public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files << "lib/darureader/reader.rb"
  spec.files << "lib/darureader/validator.rb"
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "daru", "~> 0.1.5"
  spec.add_development_dependency "roo", "~> 2.7", ">= 2.7.1"
end
