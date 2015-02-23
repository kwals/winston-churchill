puts "Welcome to Get 'er Done!"

print "Let's get to work, shall we? >"

# def add area, task
#   the_area = Area.find_or_create_by(name: area)
#   Task.create! priority_level: 0, name: task, area: the_area, complete: false
  
#   end

# def list
#   Task.where(complete: false).each {|undone| puts "#{undone.name}"}
# end


# def list_all
#   Task.find_each {|task| puts "#{task.name}"}
# end

# def list_area the_area
#   a = Area.where(name: the_area).first
#   puts "All items in #{a.name}:"
#   t = Task.where(area: a.id)
#   t.each do |t|
#     puts "#{t.name}, #{t.due}"
#   end
# end

# def due task, date
#   t = Task.find(task)
#   t.due = date
#   t.priority_level += 1
#   t.save!
# end


# def done task_number
#   t = Task.find(task_number)
#   t.complete = true
#   t.save!
# end

# def prioritize! task
#   t = Task.find(task)
#   t.priority_level += 1
#   t.save!
# end

# def geterdone! 
#   t = Task.order(priority_level: :desc).first.name
#   puts "You should work on #{t}!"
# end


# def next_up
#   Task.where.not(due: nil).order("RANDOM()").first
# end

# def search string
#   # # This should search tasks to match the string
#   # # Pretty sure this is going to iterate over something
#   #   puts "Tasks that match your search:"
#   Task.order(priority_level: :desc).each do |t|
#     if /#{string}/.match(t.name)
#       puts "#{t.name}, #{t.due}, #{t.priority_level}"
#     end
#   end
#   # q = Task.where("name ILIKE '%#{string}%'")
#   # puts "q."
# end

command = ARGV.shift

case command

when "add"
  area = ARGV.first
  task = ARGV[1]
  Area.add_task
when "search"
  user, string = ARGV
  p = User.find_by(name: user)
  p.search string
# when "prioritize!"
#   task = ARGV.first
#   prioritize! task
# when "next_up"
#   next_up
# when "geterdone!"
#   geterdone!
# when "done"
#   task_number = ARGV.first
#   done task_number
# when "list_area"
#   area = ARGV.first
#   list_area area
# when "due" 
#   task = ARGV.first
#   date = ARGV[1]
# when "list"
#     list
# when "list_all"
#   list_all
else
  # Can I write a rescue here to allow for "nomethoderror" to return this message?
  "Not there yet. Hold your horses, pal."
end