# Iterator is a behavioral design pattern that lets you traverse elements of a collection without exposing its
# underlying representation.
#
# Use this pattern when your collection has a complex data structure under the hood, but you want to hide its complexity
# from clients (either for convenience or security reasons), or to reduce duplication of the traversal code, or when you
# want your code to be able to traverse different data structures or when types of these structures are unknown
# beforehand.
class AlphabeticalOrderIterator
  include Enumerable

  attr_accessor :reverse
  private :reverse

  attr_accessor :collection
  private :collection

  def initialize(collection, reverse = false)
    @collection = collection
    @reverse = reverse
  end

  def each(&block)
    return @collection.reverse.each(&block) if reverse

    @collection.each(&block)
  end
end

class WordsCollection
  attr_accessor :collection
  private :collection

  def initialize(collection = [])
    @collection = collection
  end

  def iterator
    AlphabeticalOrderIterator.new(@collection)
  end

  def reverse_iterator
    AlphabeticalOrderIterator.new(@collection, true)
  end

  def <<(item)
    @collection << item
  end
end

collection = WordsCollection.new
collection << 'First'
collection << 'Second'
collection << 'Third'

puts 'Straight traversal:'
collection.iterator.each { |item| puts item }
puts "\n"

puts 'Reverse traversal:'
collection.reverse_iterator.each { |item| puts item }