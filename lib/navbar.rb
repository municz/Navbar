require 'erb'

class Navbar
  attr_writer :html_template_path
  attr_accessor :parent

  def initialize(name = nil, path = nil)
    @name, @path = name, path
    @children = []
  end

  def html_template_path
    @html_template_path || parent.html_template_path
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
    output = ""
    output << unless @name
      "<navbar>"
    else
      %{<item name="#{@name}" href="#{@path}"#{@children.empty? ? "/" : ""}>}
    end
    @children.each do |child|
      output << child.xml_output
    end
    output << unless @name
      "</navbar>"
    else
      @children.empty? and "" or "</item>" 
    end
    output
  end

  def path_to_name(path)
    name = nil
    if @path == path
      name = @name
    else
      @children.each do |child|
	name = child.path_to_name(path) and break
      end
    end
    name
  end
end
