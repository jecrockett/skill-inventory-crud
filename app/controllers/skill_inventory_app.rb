require 'pony'

class SkillInventoryApp < Sinatra::Base

  get '/skills' do
    @skills = SkillInventory.all
    haml :index
  end

  get '/skills/new' do
    haml :new
  end

  post '/skills' do
    SkillInventory.create(params[:skill])
    Pony.mail(to: 'jecrockett@gmail.com',
              from: 'jecrockett@gmail.com',
              subject: "You added a new skill!",
              body: "Added a skill!.")
    redirect '/skills'
  end

  get '/skills/:id' do |id|
    @skill = SkillInventory.find(id.to_i)
    haml :show
  end

  get '/skills/:id/edit' do |id|
    @skill = SkillInventory.find(id.to_i)
    haml :edit
  end

  put '/skills/:id' do |id|
    SkillInventory.update(id.to_i, params[:skill])
    redirect "/skills/#{id}"
  end

  delete '/skills/:id' do |id|
    SkillInventory.delete(id.to_i)
    redirect "/skills"
  end

  not_found do
    haml :error
  end

end
