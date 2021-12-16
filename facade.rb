# Facade is a structural design pattern that provides a simplified interface to a library, a framework, or any other
# complex set of classes.
#
# Use this pattern when you need to provide simple interface to complex subsystem or when you want to divide
# subsystem to separate layers. Facade defines a new interface
# Remember to control your facade - it can become a GOD OBJECT!

class Facade
  def initialize(subsystem1, subsystem2)
    @subsystem1 = subsystem1 || Subsystem1.new
    @subsystem2 = subsystem2 || Subsystem2.new
  end

  def operation
    results = []
    results << 'Facade initializes subsystems:'
    results << @subsystem1.operation1
    results << @subsystem2.operation1
    results << 'Facade orders subsystems to perform the action:'
    results << @subsystem1.operation_n
    results << @subsystem2.operation_z
    results.join("\n")
  end
end

class Subsystem1
  def operation1
    'Subsystem1: Ready!'
  end

  def operation_n
    'Subsystem1: Go!'
  end
end

class Subsystem2
  def operation1
    'Subsystem2: Get Ready!'
  end

  def operation_z
    'Subsystem2: Fire!'
  end
end

def client_code(facade)
  puts facade.operation
end

subsystem1 = Subsystem1.new
subsystem2 = Subsystem2.new
facade = Facade.new(subsystem1, subsystem2)
client_code(facade)