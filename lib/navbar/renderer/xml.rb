class Navbar
  class Renderer

    class XML < Renderer
      def on_start
        self << "<navbar>"
        shift_indent
      end

      def on_end
        unshift_indent
        new_line
        self << "</navbar>\n"
      end

      def on_name_start(node)
        new_line
        self << %{<item name="#{ node.name }" href="#{ node.link }"}
        self << (node.children.empty? ? "/>" : ">")
        shift_indent
      end

      def on_name_end(node)
        unshift_indent
        new_line
        unless node.children.empty?
          self << "</item>"
        end
      end

      def on_children_start
        new_line
      end
    end

  end
end
