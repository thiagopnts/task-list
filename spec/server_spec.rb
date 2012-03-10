require File.dirname(__FILE__)+'/spec_helper'
require 'test/unit'
require 'json'

describe 'TaskListApp' do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end
    
    it 'should open the index page' do
        browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
        browser.get '/'
        browser.last_response.should be_ok 
        browser.last_response.body.include? 'My Task List App'
    end

    it "should receive tasks" do
        request "/tasks", :method => :get 
        last_response.body.empty? == true
    end

    it "should create tasks" do
        params = {:name=>"blah", :done=>false}
        request "/tasks", :method => :post, :params=> params.to_json
        last_response.should be_ok
    end

    it "should receive all tasks" do
        request "/tasks", :method => :get
        last_response.body.empty? == false
    end

    it "should create and updates tasks" do
        @task = Task.create(:name=>"do more tests", :done => true)
        @task.serial.should_not == 0
        @task.name.should == 'do more tests'
        @task.done.should == true
        @task.id = "123123"
        @task.save
        params = {:id=>123123, :name=>"do more tests (Done)", :done=> true}
        request "/tasks", :method => :put, :params=> params.to_json
        last_response.should be_ok
    end

    it "should delete tasks" do
        params = {"id"=>123123}
        request "/tasks", :method => :delete, :params=>params
    end

    it "should not have more tasks" do
        request "/tasks", :method => :get
        last_response.body.empty? == true
    end
end
