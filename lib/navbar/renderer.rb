class Navbar
  # Visitor-like pattern to walk throught the structure
  class Renderer

    def initialize
      @out    = ""
      @indent = ""
    end

    def render(navbar)
      on_start
      walk(navbar)
      on_end
      @out
    end

    # Walk events:

    def on_start
    end

    def on_end
    end

    def on_name_start(node)
    end

    def on_name_end(node)
    end

    def on_children_start
    end

    def on_children_end
    end

    # Helpers:

    def new_line?
      @out.empty? || @out.end_with?("\n")
    end

    def new_line
      @out << "\n" unless new_line?
    end

    def shift_indent
      @indent += "  "
    end

    def unshift_indent
      @indent = @indent[0...-2]
    end

    def <<(val)
      @out << @indent if new_line?
      @out << val
    end

    # walk the node, triggering the correpsonding events as they occur
    def walk(node)
      if node.name
        on_name_start(node)
      end
      if node.children.any?
        on_children_start
        node.children.each { |child| walk(child) }
        on_children_end
      end
      if node.name
        on_name_end(node)
      end
    end
  end
end
