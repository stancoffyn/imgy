require 'pry'
require 'open-uri'

class UploadController < ApplicationController
  def new
    @image = Image.new  
    @tags = Tag.all
  end

  def create
    upload_params
    @image = Image.new(source_url: params[:url_field])
    if !params[:from_url].nil?
      #get the image from the interwebs via some load thang
      file_type = params[:url_field].split('.').last

      if !is_valid_file_type (file_type)

      end

      name = "#{params[:name]}.#{file_type}"

      File.open(Rails.root.join('public', 'uploads', name), 'wb') do |file|
        file.write open(params[:url_field]).read
      end

      @image.name = name

    elsif !params[:image].nil?
      #check that a file was uploaded via pick a file      
      image_io = params[:image]
      file_type = image_io.original_filename.split('.').last
  
      if !is_valid_file_type (file_type)

      end

      @image.name = "#{params[:name]}.#{file_type}"
      File.open(Rails.root.join('public', 'uploads', @image.name), 'wb') do |file|
        file.write(image_io.read)
      end  
      #edge: check for name in use 
      # check file type (ANIMATED vs. STATIC)
    end

    if !params[:animated].nil?
      @image.image_type = 'animated'
    else
      @image.image_type = 'static'
    end

    if !params[:tags].nil?
      tags = params[:tags].split(',')
      tags.each do |t|
        unless t.strip.empty?
          tag = Tag.find_by name: t.strip
          if tag.nil?
            tag = Tag.create!(name: t.strip)
          end

          @image.tags.push tag
        end
      end
    end

    respond_to do |format|
      if @image.save
        format.html { redirect_to home_path, notice: 'image was successfully created.' }
      else
        format.html { render action: 'new' }
      end    
    end
  end

  def is_valid_file_type (file_type)
    !['gif', 'jpeg', 'jpg', 'img'].rindex(file_type).nil?
  end

  def upload_params
    fields = {}
    params.require(:name)
    if !params[:image].nil?
      params.require(:image)
    end
    
    if !params[:url_field].nil? && !params[:url_field].empty?
      params.require(:url_field)
    end
    
    if !params[:from_url].nil?
      params.require(:from_url)
    end

    if !params[:animated].nil?
      params.require(:animated)
    end

    if !params[:tags].nil?
      params.require(:tags)
    end
  end
end
