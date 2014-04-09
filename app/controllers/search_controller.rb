class SearchController < ApplicationController
  def index
    params.require(:query)
    @query = params[:query]
    @all_tags = Tag.all.map { |t| t.name }
    @tags = Tag.where('name like ?', '%' + @query + '%')
    @images = Hash.new

    @tags.each do |tag|
        @images[tag.name] = tag.images
    end
  end
end
