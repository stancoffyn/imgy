class SearchController < ApplicationController
  def index
    params.require(:query)
    @query = params[:query]
    @tag = Tag.where('name like ?', '%' + @query + '%').first
    @images

    if(!@tag.nil?)
      @images = @tag.images
    end
  end
end
