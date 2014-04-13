require 'spec_helper'

describe ImageController do
  before(:each) do
    @image = Image.create!(name: 'noodle')
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', :id => @image.id
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => @image.id
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  after(:each) do
    @image.delete
  end 
end
