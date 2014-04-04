class HomeController < ApplicationController
	def index
    @images = Image.order("RAND()").limit(5)
	end
end
