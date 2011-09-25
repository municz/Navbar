require 'test/unit'
require File.expand_path("../lib/navbar.rb", File.dirname(__FILE__))

class NavbarTest < Test::Unit::TestCase
  def setup
    @navbar = Navbar.define do |n|
      n.node "User", "/user" do |u|
        u.node "Show", "/user"
        u.node "Edit", "/user/edit"
      end
    end

    html_template_path = File.expand_path("template.html.erb", File.dirname(__FILE__))
    @navbar.html_template_path= html_template_path
    xml_template_path = File.expand_path("template.xml.erb", File.dirname(__FILE__))
    @navbar.xml_template_path = xml_template_path
  end

  def test_html_output
    assert_equal_ignore_space(<<EOS, @navbar.html_output)
<ul>
  <li><a href="/user">User</a>
    <ul>
      <li><a href="/user">Show</a></li>
      <li><a href="/user/edit">Edit</a></li>
    </ul>
  </li>
</ul>
EOS
  end

  def test_xml_output
    assert_equal_ignore_space(<<EOS, @navbar.xml_output)
<navbar>
  <item name="User" href="/user">
    <item name="Show" href="/user"/>
    <item name="Edit" href="/user/edit"/>
  </item>
</navbar>
EOS
  end

  def test_path_to_name
    assert_equal("Edit",@navbar.path_to_name("/user/edit"))
  end

  def test_all_addresses
    assert_equal(%w{/user /user/edit},@navbar.all_addresses)
  end

  def test_advanced_dsl
    @navbar_2 = Navbar.define! do
      node "User", "/user" do
        node "Show", "/user"
        node "Edit", "/user/edit"
      end
    end
    assert_equal(@navbar.all_addresses, @navbar_2.all_addresses)
  end

  def assert_equal_ignore_space(expected, current)
    assert_equal(expected.gsub(/\s/,""), current.gsub(/\s/,""))
  end


end
