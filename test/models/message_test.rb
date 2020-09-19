# frozen_string_literal: true

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages(:message_to_la_tania_from_matthieu)
  end

  test "valid message" do
    assert @message.valid?
  end

  %i(user booking content).each do |attibute|
    test "invalid message without #{attibute}" do
      @message.send("#{attibute}=", nil)
      assert_not @message.valid?
      assert_not_nil @message.errors[attibute]
    end
  end

  test "invalid message with too big content" do
    @message.content = "a" * (Message::CONTENT_MAX + 1)
    assert_not @message.valid?
    assert_not_nil @message.errors[:content]
  end

  test "invalid message with too small content" do
    @message.content = "a"
    assert_not @message.valid?
    assert_not_nil @message.errors[:content]
  end
end
