require 'aruba/cucumber'

Before do
  if RUBY_PLATFORM =~ /java/
    @aruba_timeout_seconds = 30
  else
    @aruba_timeout_seconds = 10
  end
end

Aruba.configure do |config|
  config.before_cmd do |cmd|
    set_env('JRUBY_OPTS', "-X-C #{ENV['JRUBY_OPTS']}") # disable JIT since these processes are so short lived
  end
end if RUBY_PLATFORM == 'java'

Aruba.configure do |config|
  config.before_cmd do |cmd|
    set_env('RBXOPT', "-Xint=true #{ENV['RBXOPT']}") # disable JIT since these processes are so short lived
  end
end if defined?(Rubinius)
