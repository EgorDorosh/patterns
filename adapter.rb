# Adapter is a structural design pattern that allows objects with incompatible interfaces to collaborate.
#
# Use this pattern when you need to use third-party class that uses an interface that not corresponds to other code in
# your application. Adapter changes interface of an existing wrapped object.

class Target
  def request
    'Target: The default target\'s behaviour.'
  end
end

class Adaptee
  def specific_request
    '.eetpadA eht fo roivaheb laicepS'
  end
end

class Adapter < Target
  def initialize(adaptee)
    @adaptee = adaptee
  end

  def request
    "Adapter: (TRANSLATED) #{@adaptee.specific_request.reverse!}"
  end
end

def client_code(target)
  p target.request
end

p 'Client: I can work just fine with the Target objects:'
target = Target.new
client_code(target)
puts "\n\n"

adaptee = Adaptee.new
p 'Client: The Adaptee class has a weird interface. See, I don\'t understand it:'
p "Adaptee: #{adaptee.specific_request}"
puts "\n"

p 'Client: But I can work with it via Adapter:'
adapter = Adapter.new(adaptee)
client_code(adapter)
