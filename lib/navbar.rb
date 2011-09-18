require 'erb'
class Navbar
  attr_reader :name, :href
  attr_accessor :parent
  include Enumerable
  def initialize(name = nil, href = nil)
    @name, @href = name, href
    @children = []
  end

  [:html, :xml].each do |format|
    class_eval <<DEF, __FILE__, __LINE__
    def #{format}_template=(#{format}_template)
      @#{format}_template = ERB.new(#{format}_template)
    end

    def #{format}_template
      @#{format}_template || self.parent && self.parent.#{format}_template
    end

    def #{format}
      #{format}_template.result(self.send :binding)
    end
DEF
  end

  def <<(child)
    @children << child
    child.parent = self
  end

  def each(&block)
    yield self
    @children.each { |child| child.each(&block) }
  end

  def address_to_name(address)
    if node = self.find {|n| n.href == address}
      return node.name
    end
  end

  def all_addresses
    self.map {|n| n.href}.compact.uniq
  end
end
