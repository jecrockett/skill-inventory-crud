require_relative '../test_helper'

class DeleteSkillTest < FeatureTest

  def test_delete_an_existing_skill
    SkillInventory.create({ title: "a title", description: "a description" })

    visit './skills'

    within "#skills-index" do
      assert page.has_content?("a title")
    end

    click_button("Delete")

    assert_equal '/skills', current_path
    within "#skills-index" do
      refute page.has_content?("a title")
    end
  end

end
