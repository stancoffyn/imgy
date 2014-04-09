class HomeController < ApplicationController
	def index
    @images = Image.order("RAND()").limit(20).load
    @tags = Tag.all.map { |t| t.name}
	end
end
