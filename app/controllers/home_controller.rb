class HomeController < ApplicationController
	def index
    @images = Image.order("RAND()").limit(browser.mobile? ? 10 : 40).load
    @tags = Tag.all.map { |t| t.name}
	end
end
