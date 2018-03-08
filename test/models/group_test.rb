require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  test 'should not save group without tournament' do
    group = Group.new(name: 'test group')
    assert_not group.save
  end
end
