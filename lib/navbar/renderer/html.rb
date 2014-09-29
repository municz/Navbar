class Navbar
  class Renderer

    class HTML < Renderer
      def on_name_start(node)
        new_line
        self << %{<li><a href="#{ node.link }">#{ node.name }</a>}
        shift_indent
      end

      def on_name_end(node)
        unshift_indent
        self << "</li>"
      end

      def on_children_start
        new_line
        self << "<ul>"
        shift_indent
      end

      def on_children_end
        unshift_indent
        new_line
        self << "</ul>"
        new_line
      end
    end

  end
end
