# Chain Of Responsibility is a behavioral design pattern that lets you pass requests along a chain of handlers. Upon
# receiving a request, handler decides either to process the request or to pass it to the next handler in the chain.
#
# Use this pattern when your program is expected to process different kinds of requests in various ways, but the exact
# types of requests and their sequences are unknown beforehand, or when it's essential to execute several handlers in a
# particular order, or when the set of handlers and their order are supposed to change at runtime.
#
# @abstract
class Handler
  # @abstract
  def next_handler=(handler)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def handle(request)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class AbstractHandler < Handler
  attr_writer :next_handler

  def next_handler(handler)
    @next_handler = handler
    handler
  end

  def handle(request)
    return @next_handler.handle(request) if @next_handler

    nil
  end
end

class MonkeyHandler < AbstractHandler
  def handle(request)
    request == 'Banana' ? "Monkey: I'll eat the #{request}" : super(request)
  end
end

class SquirrelHandler < AbstractHandler
  def handle(request)
    request == 'Nut' ? "Squirrel: I'll eat the #{request}" : super(request)
  end
end

class DogHandler < AbstractHandler
  def handle(request)
    request == 'MeatBall' ? "Dog: I'll eat the #{request}" : super(request)
  end
end

def client_code(handler)
  ['Nut', 'Banana', 'Cup of coffee'].each do |food|
    puts "\nClient: Who wants a #{food}?"
    result = handler.handle(food)
    if result
      print "  #{result}"
    else
      print "  #{food} was left untouched."
    end
  end
end

monkey = MonkeyHandler.new
squirrel = SquirrelHandler.new
dog = DogHandler.new

monkey.next_handler(squirrel).next_handler(dog)

puts 'Chain: Monkey > Squirrel > Dog'
client_code(monkey)
puts "\n\n"

puts 'Subchain: Squirrel > Dog'
client_code(squirrel)