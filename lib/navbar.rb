require 'erb'

class Navbar
  attr_writer :html_template_path, :xml_template_path
  attr_accessor :parent
  attr_reader :name, :path
  include Enumerable

  def initialize(name = nil, path = nil)
    @name, @path = name, path
    @children, @html_template_path, @xml_template_path = [], nil, nil
  end

  def each(&block)
    yield self
    @children.each { |child| child.each(&block) }
  end

  def html_template_path
    @html_template_path || parent.html_template_path
  end

  def xml_template_path
    @xml_template_path || parent.xml_template_path
  end

  def add_child(child)
    @children << child
    child.parent = self
  end

  def html_output
    template = ERB.new(File.read(html_template_path))
    template.result(self.send :binding)
  end

  def xml_output
    template = ERB.new(File.read(xml_template_path))
    template.result(self.send :binding)
  end

  def path_to_name(path)
    node = self.find {|n| n.path == path } and return node.name
  end

  def all_addresses
    map(&:path).compact.uniq
  end
end
