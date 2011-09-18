require 'erb'
class Navbar
  attr_accessor :parent
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

  def add_child(child)
    @children << child
    child.parent = self
  end

  def address_to_name(address)
    if @href == address
      return @name
    else
      @children.each do |child|
        if name = child.address_to_name(address)
          return name
        end
      end
    end
    return nil
  end

  def all_addresses
    ret = []
    ret << @href if @href
    @children.each do |child|
      ret += child.all_addresses
    end
    return ret.uniq
  end
end
