# Navbar

This is a sample project for introduction to Ruby.

Navbar is a simple site navigation utility. It allows simple definition
of site navigation that can be then used for rendering in various
formats (HTML, XML). It supports searching a name for given address and showing all addresses
defined in the navbar.

# Usage

    @navbar = Navbar.define do
      item "Home", "http://example.com"
      item "User", "http://example.com/user" do
        item "Show", "http://example.com/user"
        item "Edit", "http://example.com/user/edit"
      end
    end
    @navbar.html_template= File.read(File.expand_path("../navbar.html.erb",__FILE__))
    @navbar.xml_template= File.read(File.expand_path("../navbar.xml.erb",__FILE__))

    @navbar.html # renders html for given navigation
    @navbar.xml  # renders xml for given navigation

    @navbar.all_addresses # array of all addresses in the definition
    @navbar.address_to_name("http://example.com/user/edit") # returns "Edit"

# What have we learned?

* TDD style of writing code (see Git log)
* Commiting after each atomic change :)
* Writing Unit Tests
* Inheritence (in unit test)
* Instance and static methods
* Accessors (using attr_reader, attr_accessor and full definition)
* Basic usage of reqular expressions
* Requiring another files (local and global)
* Usage of collections
* Mixins (include Enumerable)
* Blocks and yield
* Some meta-programming (class_eval)
* Redefining operators (<<)
* ERB templates
* Writing simple DSL using yield and instance_exec


