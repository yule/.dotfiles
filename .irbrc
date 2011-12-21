
require 'rubygems'

gems = %w(wirble interactive_editor map_by_method what_methods)
gems.each{|g|
  require "#{g}"
}

Wirble.init
Wirble.colorize

def x #because I'm lazy
 exit
end

puts "IRB config loaded"
