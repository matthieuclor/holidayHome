# frozen_string_literal: true

require 'test_helper'

class TeamMemberTest < ActiveSupport::TestCase
  setup do
    @team_member = team_members(:pierre)
  end

  test 'valid team member' do
    assert @team_member.valid?
  end

  test 'default team member status must be offline' do
    assert @team_member.offline?
  end

  %i(first_name last_name function).each do |attibute|
    test "invalid team member without #{attibute}" do
      @team_member.send("#{attibute}=", nil)
      assert_not @team_member.valid?
      assert_not_nil @team_member.errors[attibute]
    end
  end

  test 'invalid online team member without photo' do
    @team_member.status = :online
    assert_not @team_member.valid?
    assert_not_nil @team_member.errors[:photo]
  end

  %i(first_name last_name function).each do |attibute|
    test "capitalize #{attibute} before save" do
      @team_member.send("#{attibute}=", 'test')
      @team_member.save
      assert_equal @team_member.send(attibute), 'Test'
    end
  end
end
