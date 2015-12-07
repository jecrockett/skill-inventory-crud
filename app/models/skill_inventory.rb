require 'yaml/store'

class SkillInventory
  def self.database
    if ENV["RACK_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/skill_inventory_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/skill_inventory_dev.sqlite3")
    end
  end

  def self.skills_table
    database.from(:skills)
  end

  def self.create(skill)
    database.from(:skills).insert(title: skill[:title], description: skill[:description])

    # database.transaction do
    #   database['skills'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['skills'] << { "id" => database['total'], "title" => skill[:title], "description" => skill[:description] }
    # end
  end

  def self.raw_data
    database.transaction do
      database['skills'] || []
    end
  end

  def self.all
    skills_table.to_a.map { |data| Skill.new(data) }
  end

  def self.find(id)
    skill_data = skills_table.where(id: id).to_a.last
    Skill.new(skill_data)
  end

  def self.update(id, data)
    skills_table.where(id: id).update(data)
  end

  def self.delete(id)
    skills_table.where(id: id).delete
    # database.transaction do
    #   database['skills'].delete_if { |skill| skill["id"] == id }
    # end
  end

end
