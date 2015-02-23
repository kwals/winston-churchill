class User < ActiveRecord::Base
  has_many :areas

 # Here's the info we have..
     # t.string :username
     #  t.string :password
     #  t.string :email
     #  t.timestamp :created_at

  def next
    s = self.id
    a = Area.order(hierarchy: :desc).first
    t = Task.where(area_id: a.id)
    t.where.not(due: nil).order("RANDOM()").first
    # Oops, make sure this doesn't include complete tasks!
  end

  def search string
    s = self.id
    binding.pry
    big_array = []
    Area.where(user_id: s).find_each do |a|
      Task.where(area_id: a).find_each do |t|
        binding.pry
        if t.name.include? string
          big_array.push(t)
        end
      end
    end
    big_array
  end

  def new_task area, task
    the_area = Area.find_or_create_by(name: area, user: self)
    the_task = Task.create!(name: task, area: the_area, complete: false, priority_level: 0)
  end

  def list_undone
    undone_array = []
     Area.where(user: self).find_each do |a|
      undone_array.push(a.undone)
      binding.pry
      end
    undone_array
    end 

  def list_all
    all_array = []
     Area.where(user: self).find_each do |a|
      all_array.push(a.all_tasks)
      binding.pry
      end
    all_array
    end 

end