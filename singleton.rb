# Singleton is a creational design pattern that lets you ensure that a class has only one instance, while providing
# a global access point to this instance.
#
# Singleton solves two problems at the same time, violating the Single Responsibility Principle:
# 1) Guarantees a class will have only one instance;
# 2) Provides a global access point to this instance.
#
# Use this pattern when you need only one instance of some class accessible to all clients (like DB access), or when
# you want to have more control over global variables.
#
# This is a Singleton example without multithreading:
class Singleton
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def some_business_logic

  end
end

s1 = Singleton.instance
s2 = Singleton.instance

if s1.equal?(s2)
  print 'Singleton works, both variables contain the same instance.'
else
  print 'Singleton failed, variables contain different instances.'
end

# And this is a singleton with multithreading:
class MtSingleton
  attr_reader :value

  @instance_mutex = Mutex.new

  private_class_method :new

  def initialize(value)
    @value = value
  end

  def self.instance(value)
    return @instance if @instance

    @instance_mutex.synchronize do
      @instance ||= new(value)
    end

    @instance
  end

  def some_business_logic

  end
end

def test_singleton(value)
  singleton = MtSingleton.instance(value)
  puts singleton.value
end

puts "If you see the same value, then singleton was reused (yay!)\n"\
     "If you see different values, then 2 singletons were created (booo!!)\n\n"\
     "RESULT:\n\n"

process1 = Thread.new { test_singleton('FOO') }
process2 = Thread.new { test_singleton('BAR') }
process1.join
process2.join