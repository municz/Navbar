require 'erb'
class Navbar
  attr_accessor :parent
  def initialize(name = nil, href = nil)
    @name, @href = name, href
    @children = []
  end

  def html_template=(html_template)
    @html_template = ERB.new(html_template)
  end

  def html_template
    @html_template || self.parent && self.parent.html_template
  end

  def xml_template=(xml_template)
    @xml_template = ERB.new(xml_template)
  end

  def xml_template
    @xml_template || self.parent && self.parent.xml_template
  end

  def add_child(child)
    @children << child
    child.parent = self
  end

  def html
    html_template.result(self.send :binding)
  end

  def xml
    xml_template.result(self.send :binding)
  end
end
