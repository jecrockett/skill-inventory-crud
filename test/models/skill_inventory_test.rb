require_relative '../test_helper'

class SkillInventoryTest < Minitest::Test

  def create_skill(num)
    num.times do |i|
      SkillInventory.create({ title: "#{i+1} title",
                              description: "#{i+1} description" })
    end
  end

  def test_it_creates_a_skill
    create_skill(1)
    skill = SkillInventory.all.last

    assert_equal "1 title", skill.title
    assert_equal "1 description", skill.description
    assert_equal SkillInventory.all.last.id, skill.id
  end

  def test_all_returns_all_skill_data
    create_skill(2)
    skills = SkillInventory.all

    assert_equal 2, skills.count
  end

  def test_it_finds_a_task_by_id
    create_skill(2)

    id = SkillInventory.all.last.id
    skill = SkillInventory.find(id)

    assert_equal "2 title", skill.title
  end

  def test_update_a_skill
    create_skill(1)
    id = SkillInventory.all.last.id
    original_skill = SkillInventory.find(id)

    assert_equal "1 title", original_skill.title

    SkillInventory.update(id, {title: "NEW title", description: "NEW description" })
    updated_skill = SkillInventory.find(id)

    assert_equal "1 title", original_skill.title
    assert_equal "NEW title", updated_skill.title
    assert_equal "NEW description", updated_skill.description
  end

  def test_delete_a_skill
    create_skill(2)
    skills_before_deletion = SkillInventory.all
    SkillInventory.delete(SkillInventory.all.last.id)
    skills_after_deletion = SkillInventory.all

    assert_equal 2, skills_before_deletion.count
    assert_equal 1, skills_after_deletion.count
  end

end
