require 'spec_helper'

describe Image do
  it 'should accept type of animated' do
    animated_image = Image.create!(name: 'test', image_type: 'animated')
    expect(animated_image.image_type).to eq('animated')
  end

  it 'should accept type of static' do
    static_image = Image.create!(name: 'test', image_type: 'static')
    expect(static_image.image_type).to eq('static')
  end
end
