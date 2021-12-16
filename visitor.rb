# Visitor is a behavioral design pattern that lets you separate algorithms from the objects on which they operate.
#
# Use this pattern when you need to perform an operation on all elements of a complex object structure, or to clean up
# the business logic of auxiliary behaviors, or when a behavior makes sense only in some classes of a class hierarchy,
# but not in others.
#
# @abstract
class Component
  # @abstract
  def accept(_visitor)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteComponentA < Component
  def accept(visitor)
    visitor.visit_concrete_component_a(self)
  end

  def exclusive_method_of_concrete_component_a
    'A'
  end
end

class ConcreteComponentB < Component
  def accept(visitor)
    visitor.visit_concrete_component_b(self)
  end

  def special_method_of_concrete_component_b
    'B'
  end
end

# @abstract
class Visitor
  # @abstract
  def visit_concrete_component_a(_element)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  def visit_concrete_component_b(_element)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteVisitor1 < Visitor
  def visit_concrete_component_a(element)
    puts "#{element.exclusive_method_of_concrete_component_a} + #{self.class}"
  end

  def visit_concrete_component_b(element)
    puts "#{element.special_method_of_concrete_component_b} + #{self.class}"
  end
end

class ConcreteVisitor2 < Visitor
  def visit_concrete_component_a(element)
    puts "#{element.exclusive_method_of_concrete_component_a} + #{self.class}"
  end

  def visit_concrete_component_b(element)
    puts "#{element.special_method_of_concrete_component_b} + #{self.class}"
  end
end

def client_code(components, visitor)
  components.each { |component| component.accept(visitor) }
end

components = [ConcreteComponentA.new, ConcreteComponentB.new]

puts 'The client code works with all visitors via the base Visitor interface:'
visitor_1 = ConcreteVisitor1.new
client_code(components, visitor_1)

puts 'It allows the same client code to work with different types of visitors:'
visitor_2 = ConcreteVisitor2.new
client_code(components, visitor_2)