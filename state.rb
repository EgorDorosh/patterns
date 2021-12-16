# State is a behavioral design pattern that lets an object alter its behavior when its internal state changes. It
# appears as if the object changed its class.
#
# Use this pattern when you have an object that behaves differently depending on its current state, the number of
# states is enormous, and the state-specific code changes frequently, or when you have a class polluted with massive
# conditionals that alter how the class behaves according to the current values of teh class's fields, or when you have
# a lot of duplicate code across similar states and transitions of a condition-based state machine.
class Context
  attr_accessor :state
  private :state

  def initialize(state)
    transition_to(state)
  end

  def transition_to(state)
    puts "Context: Transition to #{state.class}"
    @state = state
    @state.context = self
  end

  def request_1
    @state.handle_1
  end

  def request_2
    @state.handle_2
  end
end

# @abstract
class State
  attr_accessor :context

  # @abstract
  def handle_1
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  def handle_2
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteStateA < State
  def handle_1
    puts 'ConcreteStateA handles request_1.'
    puts 'ConcreteStateA want to change the state of the context.'
    @context.transition_to(ConcreteStateB.new)
  end

  def handle_2
    puts 'ConcreteStateA handles request_2.'
  end
end

class ConcreteStateB < State
  def handle_1
    puts 'ConcreteStateB handles request_1.'
  end

  def handle_2
    puts 'ConcreteStateB handles request_2.'
    puts 'ConcreteStateB wants to change the state of the context.'
    @context.transition_to(ConcreteStateA.new)
  end
end

context = Context.new(ConcreteStateA.new)

puts "\n"

context.request_1

puts "\n"

context.request_2