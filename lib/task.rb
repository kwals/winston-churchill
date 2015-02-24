class Task < ActiveRecord::Base
  belongs_to :area

  # Here's what we have
  # t.string :name
  #     t.boolean :complete
  #     t.integer :priority_level
  #     t.date :due
  #     t.belongs_to :area

  def complete!
    # this should change the boolean to true
    self.complete = true
    self.save!
  end

  def due_by due_date
    # this should assign it a a due date
    d = Date.parse(due_date)
    self.due = d
    self.save!
  end

  def prioritize!
    # this should increment the priority_level
    self.priority_level += 1
    self.save!
  end

end