class HomeController < ApplicationController
	def index
    @images = Image.order("RAND()").limit(5).load
	end
end
