lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nature_remo/version'

Gem::Specification.new do |spec|
  spec.name          = 'nature_remo'
  spec.version       = NatureRemo::VERSION
  spec.authors       = ['ichi-t']
  spec.email         = ['taisuke_ichimura@icloud.com']

  spec.summary       = 'Nature Remo API client written by Ruby'
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/ichi-t/nature_remo'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0.2'
  spec.add_development_dependency 'minitest', '~> 5.13.0'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'webmock', '~> 3.7.6'
  spec.add_runtime_dependency 'faraday', '~> 0.17.0'
  spec.add_runtime_dependency 'launchy', '~> 2.4.3'
  spec.add_runtime_dependency 'thor', '~> 0.20.3'
end
