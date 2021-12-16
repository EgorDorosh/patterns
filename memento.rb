# Memento is a behavioral design pattern that lets you save and restore the previous state of an object without
# revealing the details of its implementation.
#
# Use this pattern when you want to produce snapshots of the object's state to be able to restore a previous state of
# the object, or when direct access to the object's fields/getters/setters violates its encapsulation.
#
# Keep in mind that app might consume lots of RAM if client create mementos too often, and you should track the
# originator's lifecycle (by caretakers) to be able to destroy obsolete mementos.
class Originator
  attr_accessor :state
  private :state

  def initialize(state)
    @state = state
    puts "Originator: My initial state is: #{@state}"
  end

  def do_something
    puts 'Originator: I\'m doing something important.'
    @state = generate_random_string(30)
    puts "Originator: and my state has changed to: #{@state}"
  end

  def save
    ConcreteMemento.new(@state)
  end

  def restore(memento)
    @state = memento.state
    puts "Originator: My state has changed to: #{@state}"
  end

  private

  def generate_random_string(size = 10)
    ascii_letters = [*'a'..'z', *'A'..'Z']
    (0...size).map { ascii_letters.sample }.join
  end
end

# @abstract
class Memento
  # @abstract
  def name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def date
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteMemento < Memento
  attr_reader :state, :date

  def initialize(state)
    @state = state
    @date = Time.now.strftime('%F %T')
  end

  def name
    "#{@date} / (#{@state[0, 9]}...)"
  end
end

class Caretaker
  def initialize(originator)
    @mementos = []
    @originator = originator
  end

  def backup
    puts "\nCaretaker: Saving Originator's state..."
    @mementos << @originator.save
  end

  def undo
    return if @mementos.empty?

    memento = @mementos.pop
    puts "Caretaker: Restoring state to: #{memento.name}"
    @originator.restore(memento)
  end

  def show_history
    puts 'Caretaker: Here\'s the list of mementos:'

    @mementos.each { |memento| puts memento.name }
  end
end

originator = Originator.new('Super-duper-super-puper-super.')
caretaker = Caretaker.new(originator)

caretaker.backup
originator.do_something

caretaker.backup
originator.do_something

caretaker.backup
originator.do_something

puts "\n"
caretaker.show_history

puts "\nClient: Now, let's rollback!\n"
caretaker.undo

puts "\nClient: Once more!\n"
caretaker.undo