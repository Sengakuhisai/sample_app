require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @user=users(:michael)
    @other=users(:archer)
    @msg=@user.messages.build(content: "Kilroy was here",user_id: @user.id,to_id: @other.id)
  end
  
  test "should be valid" do
    assert @msg.valid?
  end
  
  test "content should be valid" do
    @msg.content=""
    assert_not @msg.valid?
    @msg.content="a"*501
    assert_not @msg.valid?
  end
  
  test "should msgs ordered by times" do
    assert_equal messages(:most_recent),Message.first
  end
  
  test "associated microposts should be destroyed" do
    assert_difference "Message.count",-3 do
      @user.destroy
    end
  end
end
