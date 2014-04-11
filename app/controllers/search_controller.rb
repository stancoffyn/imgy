class SearchController < ApplicationController
  def index
    params.require(:query)
    @query = params[:query]
    @all_tags = Tag.all.map { |t| t.name }
    @tags = Tag.where('name like ?', '%' + @query + '%')
    @images = []

    @tags.each do |tag|
        tag_images = tag.images
        @images.concat tag_images
    end

    @images.uniq!
  end
end
