require 'sinatra/base'
require 'pry'
require "./db/setup"
require "./lib/all"

class DoneWeb < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, '3000'
  set :method_override, true

  include ERB::Util


# Note to self, get rid of extras

    def current_user 
      # username = request.env["HTTP_AUTHORIZATION"]
      username = "Bob"
      User.find_by(username: username)
    end

  get '/tasks' do
    r = current_user.list_undone
    @tasks = r
    erb :todo_list
  end

  get '/tasks/all' do
    q = current_user.list_all
    @tasks = q
    erb :todo_list
  end

  get "/tasks/nextup" do 
    r = current_user.next
    r.to_json
  end

  patch '/complete' do
    @n = params[:id]
    t = Task.find_by(id: @n)
    t.complete!
    erb "You completed #{t.name}. 加油！！！"
  end

  patch '/due/:id' do
    n = params[:id]
    d = params[:due_date]
    t = Task.find_by(id: n)
    t.due_by d
    erb "#{t.name} is due on #{t.due}. Get crackin!"
  end

  patch '/prioritize/:id' do
    n = params[:id]
    t = Task.find_by(id: n)
    t.prioritize!
    erb "You prioritized #{t.name}. Good choice."
  end

  get '/search' do
    string = params[:phrase]
    r = current_user.search string
    @tasks = r 
    erb :todo_list
  end

  post '/add' do
    area = params[:area]
    task = params[:task]
    current_user.new_task area, task
    # @tasks = current_user.list_all
    # erb :todo_list
  end

  # Need a function to DELETE tasks
  # Would like a "geterdone" feature

end

DoneWeb.run!