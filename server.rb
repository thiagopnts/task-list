require 'rubygems'
require 'sinatra'
require 'json'
require_relative 'task'

set :public_folder, 'public'

configure :test do
    DataMapper.setup(:default, "sqlite::memory")
end

get '/' do
    send_file File.join(settings.public_folder,'index.html')
end

get '/tasks' do
    Task.all.to_json
end

post '/tasks' do
    data = JSON.parse(request.body.read)
    if !data["name"].empty?
        Task.create(:id => data["id"].to_s, :name => data["name"], :done => data["done"])
    end
end

delete '/tasks' do
    Task.first(:id => params["id"].to_s)
end

put '/tasks' do
    data = JSON.parse(request.body.read)
    if !data["name"].empty? 
        Task.first(:id => data["id"].to_s).update(:name => data["name"], :done => data["done"])
    end
end

