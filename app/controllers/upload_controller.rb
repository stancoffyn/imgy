require 'pry'
require 'open-uri'

class UploadController < ApplicationController
  before_action :authenticate_admin!
  before_action :upload_params, only: [:create]

  def new
    @image = Image.new  
    @tags = Tag.all
  end

  def create
    @image = Image.new(source_url: params[:url_field])
    if !params[:from_url].nil?
      p 'we know that we are in the upload portion now'
      @image.name = get_file_name params[:name], params[:url_field].split('.').last.split('?').first
      p 'past the new file name detection stuff'

      File.open get_file_path(@image.name), 'wb' do |file|
        file.write open(params[:url_field]).read
      end
    elsif !params[:image].nil?
      image_io = params[:image]
      @image.name = get_file_name( params[:name], image_io.original_filename.split('.').last )

      File.open(get_file_path(@image.name), 'wb') do |file|
        file.write(image_io.read)
      end  
    end

    @image.image_type = params[:animated].nil? ? 'static' : 'animated'

    if !params[:tags].nil?
      tags = params[:tags].split(',')
      tags.each do |t|
        unless t.strip.empty?
          tag = Tag.find_by name: t.strip
          tag = tag.nil? ? tag = Tag.create!(name: t.strip) : tag 
          @image.tags.push tag
        end
      end
    end

    respond_to do |format|
      if @image.save
        format.html { redirect_to home_path, notice: 'image was successfully created.' }
      else
        format.html { render action: 'new', alert: 'An error occured saving the record to the database.' }
      end    
    end
  end

  def get_file_name(file_name, file_type)
    unless !File.exists? get_file_path("#{file_name}.#{file_type}")
      path = get_file_path "#{file_name}.#{file_type}"
      p "file exists I guess: #{path}"
      append = 0
      begin
        append += 1
        p 'adding another number'
      end while (File.exists?(get_file_path("#{file_name} #{append}.#{file_type}"))) || append > 10

      file_name = "#{file_name} #{append}"
    end
    
    "#{file_name}.#{file_type}"
  end

  def get_file_path(filename)
    Rails.root.join('public', 'uploads', filename)
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
