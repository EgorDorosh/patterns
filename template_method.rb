# Template Method is a behavioral design patter that defines the skeleton of an algorithm in the superclass but lets
# subclasses override specific steps of the algorithm without changing its structure.
#
# Use this pattern when you want to let clients extend only particular steps of an algorithm, but not the whole
# algorithm or its structure, or when you have several classes that contain almost identical algorithms with some minor
# differences. As a result, you might need to modify all classes when the algorithm changes.
#
# Keep in mind that you might violate Liskov Substitution Principle by suppressing a default step implementation via a
# subclass.
#
# @abstract
class AbstractClass
  def template_method
    base_operation_1
    required_operations_1
    base_operation_2
    hook_1
    required_operations_2
    base_operation_3
    hook_2
  end

  def base_operation_1
    puts 'AbstractClass says: I am doing the bulk of work'
  end

  def base_operation_2
    puts 'AbstractClass says: But I let subclasses override some operations'
  end

  def base_operation_3
    puts 'AbstractClass says: But I am doing the bulk of the work anyway.'
  end

  # @abstract
  def required_operations_1
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  def required_operations_2
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # These are "hooks". Subclasses can override them, but it's not mandatory. Hooks provide additional extension points
  # in some crucial places of the algorithm.
  def hook_1; end

  def hook_2; end
end

class ConcreteClass1 < AbstractClass
  def required_operations_1
    puts 'ConcreteClass1 says: Implemented Operation_1'
  end

  def required_operations_2
    puts 'ConcreteClass1 says: Implemented Operation_2'
  end
end

class ConcreteClass2 < AbstractClass
  def required_operations_1
    puts 'ConcreteClass2 says: Implemented Operation_1'
  end

  def required_operations_2
    puts 'ConcreteClass2 says: Implemented Operation_2'
  end

  def hook_1
    puts 'ConcreteClass2 says: Overridden Hook_1'
  end
end

def client_code(abstract_class)
  abstract_class.template_method
end

puts 'Same client code can work with different subclasses:'
client_code(ConcreteClass1.new)
puts "\n"

puts 'Same client code can work with different subclasses:'
client_code(ConcreteClass2.new)