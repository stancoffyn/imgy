require 'spec_helper'

describe HomeController do
  it 'should load' do
    get 'index'
    response.should be_success
  end
end 
