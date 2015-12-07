require_relative '../test_helper'

class ReadingSkillsTest < FeatureTest

  def test_user_can_read_skills_list
    SkillInventory.create({ title: "a title", description: "a description" })

    visit '/skills'

    within "#skills-index" do
      assert page.has_content?("My Skills")
    end
  end

  def test_user_can_read_a_single_skill
    SkillInventory.create({ title: "a title", description: "a description" })
    id = SkillInventory.all.last.id

    visit "/skills"
    click_link("skill-link")

    assert_equal "/skills/#{id}", current_path
    within "#skill-content" do
      assert page.has_content?("a description")
    end
  end

end
