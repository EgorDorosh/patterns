# Flyweight is a structural design pattern that lets you fit more objects into the available amount of RAM by sharing
# common parts of state between multiple objects instead of keeping all of the data in each object.
#
# Use this pattern when you have a lack of RAM to support all necessary objects.

require 'json'

class Flyweight
  def initialize(shared_state)
    @shared_state = shared_state
  end

  def operation(unique_state)
    s = @shared_state.to_json
    u = unique_state.to_json
    print "Flyweight: Displaying shared (#{s}) and unique (#{u}) state."
  end
end

class FlyweightFactory
  def initialize(initial_flyweights)
    @flyweights = {}
    initial_flyweights.each {|state| @flyweights[get_key(state)] = Flyweight.new(state)}
  end

  def get_key(state)
    state.sort.join('_')
  end

  def get_flyweight(shared_state)
    key = get_key(shared_state)

    if @flyweights.key?(key)
      puts 'FlyweightFactory: Reusing existing flyweight.'
    else
      puts "FlyweightFactory: Can't find a flyweight, creating new one."
      @flyweights[key] = Flyweight.new(shared_state)
    end

    @flyweights[key]
  end

  def list_flyweights
    puts "FlyweightFactory: I have #{@flyweights.size} flyweights."
    print @flyweights.keys.join("\n")
  end
end

def add_car_to_police_database(factory, plates, owner, brand, model, color)
  puts "\n\nClient: Adding a car to database."
  flyweight = factory.get_flyweight([brand, model, color])
  flyweight.operation([plates, owner])
end

factory = FlyweightFactory.new([
                                 %w(Chevrolet Camaro2018 pink),
                                 ['Mercedes Benz', 'C300', 'black'],
                                 ['Mercedes Benz', 'C500', 'red'],
                                 %w(BMW M5 red),
                                 %w(BMW x6 white)
                               ])

factory.list_flyweights

add_car_to_police_database(factory, 'CL234IR', 'James Doe', 'BMW', 'M5', 'red')

add_car_to_police_database(factory, 'CL234IR', 'James Doe', 'BMW', 'X1', 'red')

puts "\n\n"

factory.list_flyweights