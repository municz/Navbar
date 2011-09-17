class Navbar
  def initialize(name = nil, href = nil)
    @name, @href = name, href
    @children = []
  end

  def add_child(child)
    @children << child
  end

  def html
    out = ""
    if @name
      out << "<li>"
      out << "<a href=\"#{@href}\">#{@name}</a>"
    end
    unless @children.empty?
      out << "<ul>"
      @children.each { |child| out << child.html }
      out << "</ul>"
    end
    if @name
      out << "</li>"
    end
    out
  end
end
