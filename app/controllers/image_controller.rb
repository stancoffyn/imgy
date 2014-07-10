require 'pry'
require 'fileutils'

class ImageController < ApplicationController
  before_action :set_image, only: [:edit, :show, :update]
  before_action :authenticate_admin!, only: [:edit, :update]
  #decrypted_back = crypt.decrypt_and_verify(encrypted_data)

  def self.image_secret
    return 'c897556ee24a6b3ba2f23e8cc7551555ffb6376c59b1356617425b0ee29cb1847b5661884ac6cdea58346a9b0ee624e2c8db27a35539791fd76e1f0b050383ab'
  end

  def edit
    @tags = Tag.select([:name]).map{ |t| t.name}
    split_file_name = @image.name.split '.'
    image_file_type = split_file_name.pop
    crypt = ActiveSupport::MessageEncryptor.new(ImageController.image_secret)
    @encrypted_image_file_type = crypt.encrypt_and_sign(image_file_type)
    @name = split_file_name.join '.'
  end

  def update
    image = Image.find(params[:id])
    crypt = ActiveSupport::MessageEncryptor.new(ImageController.image_secret)
    image_file_type = crypt.decrypt_and_verify(params[:image_file_type])
    image_name = params[:name].strip.downcase
    tags = params[:tags].strip.downcase
    image_type = params[:image][:image_type]
    old_image_name = image.name
    old_image_friendly_name = old_image_name.split '.'
    file_type = old_image_friendly_name.pop

    unless image_name.empty?
      # Make sure that the image name is changed before updating
      unless old_image_friendly_name.join('.') == image_name
        image.name = "#{image_name}.#{file_type}"
        
        #move the file since it's different now.
        old_file_path = Rails.root.join('public', 'uploads', old_image_name)
        new_file_path = Rails.root.join('public', 'uploads', image.name)
        
        FileUtils.mv(old_file_path, new_file_path)
      end
    end

    image.image_type = image_type

    # reset the tags and re-assign
    image.tags.clear
    tags.split(',').each do |tag_name|
      unless tag_name.strip.empty?
        tag = Tag.where(name: tag_name.strip)
        if tag.empty?
          tag = Tag.create!(name: tag_name.strip)
        end
        image.tags.append(tag)
      end
    end

    respond_to do |format|
      if image.save
        format.html { redirect_to image_index_path, notice: 'image was successfully created.' }
      else
        format.html { render action: 'index' }
      end    
    end
  end

  def show
  end

  def index
    @images = Image.all
  end

  def set_image
    @image = Image.find(params[:id])
  end
end
