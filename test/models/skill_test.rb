require_relative '../test_helper'

class SkillTest < Minitest::Test

  def test_assigns_attributes_correctly
    skill = Skill.new({ :title => "a title", :description => "a description", :id => 1 })

    assert_equal "a title", skill.title
    assert_equal "a description", skill.description
    assert_equal 1, skill.id
  end

end
