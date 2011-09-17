class Navbar
  def initialize(name = nil, href = nil)
    @name, @href = name, href
    @children = []
  end

  def add_child(child)
    @children << child
  end
end
