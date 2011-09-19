require 'erb'

class NavbarConfig
  def initialize(navbar, &block)
    @navbar = navbar
    instance_exec(&block)
  end

  def item(name, href, &block)
    child = Navbar.new(name, href)
    @navbar << child

    NavbarConfig.new(child, &block) if block_given?
  end
end

class Navbar
  attr_reader :name, :href
  attr_accessor :parent

  include Enumerable

  def initialize(name = nil, href = nil)
    @name, @href = name, href
    @children = []
  end

  [:html, :xml].each do |format|
    class_eval <<-DEF, __FILE__, __LINE__
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
    found_address = self.find { |node| node.href == address } and return found_address.name
  end

  def all_addresses
    self.map { |node| node.href }.compact.uniq
  end

  def self.define(&block)
    navbar = Navbar.new
    config = NavbarConfig.new(navbar, &block)

    navbar
  end
end
