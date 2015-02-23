require 'sinatra/base'
require 'pry'
require "./db/setup"
require "./lib/all"

class DoneWeb < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, '3000'

    def current_user 
      # username = request.env["HTTP_AUTHORIZATION"]
      username = "Bob"
      User.find_by(username: username)
    end

  get '/tasks' do
    r = current_user.list_undone.each {|x| x.to_json}
    erb "#{r}"
  end

  get '/tasks/all' do
    r = current_user.list_all
    r.to_json
  end

  get "/tasks/nextup" do 
    r = current_user.next
    r.to_json
  end

  patch '/complete/:id' do
    n = params[:id]
    t = Task.find_by(id: n)
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

# Search function is not pretty, but it works. Let's refactor.
  get '/search' do
    string = params[:phrase]
    r = current_user.search string
    binding.pry
    r.to_json
  end


end

DoneWeb.run!