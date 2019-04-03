require "#{MRUBY_ROOT}/lib/mruby/source"

MRuby::Gem::Specification.new('mruby-pathfinder-client') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Giovanni Sakti'
  spec.version = '0.0.1'
  spec.add_dependency('mruby-env')
  spec.add_dependency('mruby-iijson')
  spec.add_dependency('mruby-simplehttp')
  spec.add_dependency('mruby-uuid')
end