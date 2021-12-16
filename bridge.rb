# Bridge is a structural design pattern that lets you split a large class or a set of closely related classes into two
# separate hierarchies - abstraction and implementation - which can be developed independently of each other.
#
# Use this pattern when you need to divide a monolith class that has several different variants of some functionality
# (like when a class should work with various DB servers), or when you want to extend a class is several orthogonal
# dimensions, or when you need to be able to switch implementations at runtime.
class Abstraction
  def initialize(implementation)
    @implementation = implementation
  end

  def operation
    "Abstraction: Base operation with:\n"\
    "#{@implementation.operation_implementation}"
  end
end

class ExtendedAbstraction < Abstraction
  def operation
    "ExtendedAbstraction: Extended operation with:\n"\
    "#{@implementation.operation_implementation}"
  end
end

# @abstract
class Implementation
  # @abstract
  def operation_implementation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteImplementationA < Implementation
  def operation_implementation
    'ConcreteImplementationA: Here\'s the result on the platform A.'
  end
end

class ConcreteImplementationB < Implementation
  def operation_implementation
    'ConcreteImplementationA: Here\'s the result on the platform B.'
  end
end

def client_code(abstraction)
  print abstraction.operation
end

implementation = ConcreteImplementationA.new
abstraction = Abstraction.new(implementation)
client_code(abstraction)

puts "\n\n"

implementation = ConcreteImplementationB.new
abstraction = ExtendedAbstraction.new(implementation)
client_code(abstraction)