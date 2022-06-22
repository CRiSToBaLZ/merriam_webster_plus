lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "merriam_webster_plus/version"

Gem::Specification.new do |spec|
  spec.name          = "merriam_webster_plus"
  spec.version       = MerriamWebsterPlus::VERSION
  spec.authors       = ["Christopher J. Corona"]
  spec.email         = ["CRiSToBaLZ@users.noreply.github.com"]

  spec.summary       = "Easily get word definitions, synonyms/antonyms, usage examples, audio pronunciations, and more! Backed by Merriam-Webster API."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/CRiSToBaLZ/merriam_webster_plus"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.executables   = ["mwp"]
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 2.3"
  spec.add_dependency "httparty"
  spec.add_dependency "json"
  spec.add_dependency "minitest"
  spec.add_dependency "minitest-stub-const"
  spec.add_dependency "rake"
  spec.add_dependency "rubocop"
  spec.add_dependency "vcr"
  spec.add_dependency "webmock"
end
