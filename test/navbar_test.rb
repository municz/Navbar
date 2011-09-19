require 'test/unit'
require File.expand_path("../lib/navbar", File.dirname(__FILE__))

class NavbarTest < Test::Unit::TestCase
  def setup
    @navbar = Navbar.define do
      item "Home", "http://example.com"
      item "User", "http://example.com/user" do
        item "Show", "http://example.com/user"
        item "Edit", "http://example.com/user/edit"
      end
    end

    @navbar.html_template = File.read(File.expand_path("../navbar.html.erb", __FILE__))
    @navbar.xml_template = File.read(File.expand_path("../navbar.xml.erb", __FILE__))
  end

  def test_html_output
    assert_equal_ignore_space(<<-HTML, @navbar.html)
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
    assert_equal_ignore_space(<<-XML, @navbar.xml)
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

  def test_all_addresses
    expected = ["http://example.com","http://example.com/user", "http://example.com/user/edit"]
    current = @navbar.all_addresses
    assert_equal(expected, current)
  end

  def assert_equal_ignore_space(expect, current)
    assert_equal(expect.gsub(/\s/,""), current.gsub(/\s/,""))
  end
end