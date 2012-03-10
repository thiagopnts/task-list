require 'rubygems'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/taskslistapp')

class Task
    include DataMapper::Resource
    property :serial, Serial
    property :id, String 
    property :name, String
    property :done, Boolean
end

DataMapper.auto_upgrade!
