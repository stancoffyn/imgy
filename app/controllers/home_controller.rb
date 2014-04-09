class HomeController < ApplicationController
	def index
    @images = Image.order("RAND()").limit(20).load
	end
end
