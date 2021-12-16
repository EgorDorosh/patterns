# Proxy is a structural design pattern that lets you provide a substitute or placeholder for another object. A proxy
# controls access to the original object, allowing you to perform something either before or after the request gets
# through to the original object.
#
# Use this pattern when you need to implement lazy initialization (like virtual proxy), or as a security proxy
# (to protect object from unauthorized access), or as a logging proxy (to store a history of requests to the object).
# Proxy has the same interface as a wrapped object.
#
# @abstract
class Subject
  # @abstract
  def request
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class RealSubject < Subject
  def request
    p 'RealSubject: Handling request.'
  end
end

class Proxy < Subject
  def initialize(real_subject)
    @real_subject = real_subject
  end

  def request
    return unless check_access

    @real_subject.request
    log_access
  end

  def check_access
    p 'Proxy: Checking access prior to firing a real request.'
    true
  end

  def log_access
    p 'Proxy: Logging the time of request.'
  end
end

def client_code(subject)
  subject.request
end

p 'Client: Executing the client code with a real subject:'
real_subject = RealSubject.new
client_code(real_subject)

puts "\n"

p 'Client: Executing the same client code with a proxy:'
proxy = Proxy.new(real_subject)
client_code(proxy)