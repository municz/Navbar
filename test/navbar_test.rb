require 'test/unit'
require File.expand_path("../lib/navbar",File.dirname(__FILE__))

class NavbarTest < Test::Unit::TestCase
  def setup
    @navbar = Navbar.new
    home = Navbar.new("Home", "http://example.com")
    @navbar.add_child(home)
    user = Navbar.new("User", "http://example.com/user")
    user_show = Navbar.new("Show", "http://example.com/user")
    user_edit = Navbar.new("Edit", "http://example.com/user/edit")
    user.add_child(user_show)
    user.add_child(user_edit)
    @navbar.add_child(user)
    @navbar.html_template= File.read(File.expand_path("../navbar.html.erb",__FILE__))
    @navbar.xml_template= File.read(File.expand_path("../navbar.xml.erb",__FILE__))
  end

  def test_html_output
    assert_equal_ignore_space(<<HTML, @navbar.html)
<ul>
  <li><a href="http://example.com">Home</a></li>
  <li>
    <a href="http://example.com/user">User</a>
    <ul>
      <li><a href="http://example.com/user">Show</a></li>
      <li><a href="http://example.com/user/edit">Edit</a></li>
    </ul>
  </li>
</ul>
HTML
  end

  def test_xml_output
    assert_equal_ignore_space(<<XML, @navbar.xml)
<navbar>
  <item name="Home" href="http://example.com"/>
  <item name="User" href="http://example.com/user">
    <item name="Show" href="http://example.com/user"/>
    <item name="Edit" href="http://example.com/user/edit"/>
  </item>
</navbar>
XML
  end

  def test_address_to_name
    assert_equal("Edit", @navbar.address_to_name("http://example.com/user/edit"))
  end

  def assert_equal_ignore_space(expect, current)
    assert_equal(expect.gsub(/\s/,""),current.gsub(/\s/,""))
  end
end
