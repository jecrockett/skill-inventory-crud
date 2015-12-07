require_relative '../test_helper'

class CreateSkillTest < FeatureTest

  def test_creating_a_new_skill
    visit '/skills/new'

    fill_in("skill[title]", with: "Eating Food")
    fill_in("skill[description]", with: "I eat food super great.")
    click_button("submit-button")

    assert_equal '/skills', current_path
    within "#skills-index" do
      assert page.has_content?("Eating Food")
    end
  end

end
