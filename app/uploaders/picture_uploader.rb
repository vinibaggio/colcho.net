# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [500, 500]

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
