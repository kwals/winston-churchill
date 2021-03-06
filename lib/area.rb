class Area < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  # Here's what we have
  #  t.string :name
  #     t.timestamp :created_at
  #     t.integer :hierarchy
  #     t.belongs_to :user

    def self.search string
      array_of_matches = []
      Task.find_each do |t|
        if /#{string}/.match(t.name)
          array_of_matches.push(t.name, t.priority_level)
        end
      end
      array_of_matches
    end

    def add_task task_name
      Task.create! name: task_name, area: (self.name)
    end

    def undone
      Task.where(area_id: self, complete: false)
    end

    def all_tasks
      Task.where(area_id: self)
    end


end