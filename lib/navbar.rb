require 'navbar/renderer'
require 'navbar/renderer/html'
require 'navbar/renderer/xml'

class Navbar
  attr_reader :name, :link, :children

  def initialize(name = nil, link = nil)
    @name     = name
    @link     = link
    @children = []
  end

  def add_child(child)
    @children << child
  end

  def html_output
    Renderer::HTML.new.render(self)
  end

  def xml_output
    Renderer::XML.new.render(self)
  end
end
