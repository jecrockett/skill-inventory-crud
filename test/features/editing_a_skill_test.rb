require_relative '../test_helper'

class EditSkillsTest < FeatureTest

  def test_editing_an_existing_skill
    SkillInventory.create({ title: "a title", description: "a description" })
    id = SkillInventory.all.last.id

    visit "/skills/#{id}/edit"
    fill_in("skill[title]", with: "NEW title")
    fill_in("skill[description]", with: "NEW description")
    click_button("submit-button")



    assert_equal "/skills/#{id}", current_path
    within "#skill-content" do
      assert page.has_content?("NEW title")
      assert page.has_content?("NEW description")
    end
  end

end
