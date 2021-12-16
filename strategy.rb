# Strategy is a behavioral design pattern that lets you define a family of algorithms, put each of them into a
# separate class, and make their objects interchangeable.
#
# Use this pattern when yuo want to use different variants of an algorithm within and object and be able to switch from
# one algorithm to another during runtime, or when you have a lot of similar classes that only differ in the way they
# execute some behavior, or to isolate the business logic of a class from the implementation details of algorithms that
# may not be as important in the context of that logic, or when your class has a massive conditional operator that
# switches between different variants of the same algorithm.
#
# This pattern may look similar to State, as they both based on composition, but the difference is that the State
# doesn't restricts dependencies between concrete states, letting them alter the state of the context at will. In
# Strategy objects don't know about each other, they are never connected.
class Context
  attr_writer :strategy

  def initialize(strategy)
    @strategy = strategy
  end

  def do_some_business_logic
    puts 'Context: Sorting data using the strategy (not sure how it\'ll do it)'
    result = @strategy.do_algorithm(%w(a b c d e))
    print result.join(', ')
  end
end

# @abstract
class Strategy
  # @abstract
  def do_algorithm(_data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteStrategyA < Strategy
  def do_algorithm(data)
    data.sort
  end
end

class ConcreteStrategyB < Strategy
  def do_algorithm(data)
    data.sort.reverse
  end
end

context = Context.new(ConcreteStrategyA.new)
puts 'Client: Strategy is set to normal sorting.'
context.do_some_business_logic
puts "\n\n"

puts 'Client: Strategy is set to reverse sorting.'
context.strategy = ConcreteStrategyB.new
context.do_some_business_logic