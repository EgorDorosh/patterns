# Decorator is a structural design pattern that lets you attach new behaviors to objects by placing these objects
# inside special wrapper objects that contain the behaviors.
#
# Use this pattern when you need to extend class without inheritance. Decorator improves some object without changing
# its interface.

class Component
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteComponent < Component
  attr_accessor :component

  def operation
    'ConcreteComponent'
  end
end

class Decorator < Component
  attr_accessor :component

  def initialize(component)
    @component = component
  end

  def operation
    @component.operation
  end
end

class ConcreteDecoratorA < Decorator
  def operation
    "ConcreteDecoratorA(#{@component.operation})"
  end
end

class ConcreteDecoratorB < Decorator
  def operation
    "ConcreteDecoratorB(#{@component.operation})"
  end
end

def client_code(component)
  p "RESULT: #{component.operation}"
end

simple = ConcreteComponent.new
p 'Client: I\'ve got a simple component:'
client_code(simple)
puts "\n\n"

decorator1 = ConcreteDecoratorA.new(simple)
decorator2 = ConcreteDecoratorB.new(simple)
puts 'Client: Now I\'ve got a decorated components:'
client_code(decorator1)
client_code(decorator2)