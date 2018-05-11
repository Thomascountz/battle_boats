
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "battle_boats/version"

Gem::Specification.new do |spec|
  spec.name          = "battle_boats"
  spec.version       = BattleBoats::VERSION
  spec.authors       = ["Thomas Countz"]
  spec.email         = ["thomascountz@gmail.com"]

  spec.summary       = %q{Ruby gem implementation of the game, Battleship}
  spec.description   = %q{Battleship is a two-player guessing game. More details can be found here: https://en.wikipedia.org/wiki/Battleship_(game)}
  spec.homepage      = "https://www.github.com/thomascountz/battle_boats"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["battle_boats"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.42"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
