$LOAD_PATH << File.expand_path('../lib', File.dirname(__FILE__))

require 'minitest/autorun'
require 'navbar'

class NavbarTest < MiniTest::Unit::TestCase
  def setup
    @navbar = Navbar.new
    user = Navbar.new("User","/user")
    @navbar.add_child(user)
    user_show = Navbar.new("Show","/user")
    user.add_child(user_show)
    user_edit = Navbar.new("Edit","/user/edit")
    user.add_child(user_edit)
  end

  def test_html_output
    assert_equal(<<EOS, @navbar.html_output)
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
    assert_equal(<<EOS, @navbar.xml_output)
<navbar>
  <item name="User" href="/user">
    <item name="Show" href="/user"/>
    <item name="Edit" href="/user/edit"/>
  </item>
</navbar>
EOS
  end
end
