require 'rubygems'
require 'bundler/setup'

require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'
require 'dotenv'

Dotenv.load

if Cloudinary.config.api_key.blank?
  Cloudinary.config do |config|
    config.cloud_name = ENV['cloudinary_cloud_name']
    config.api_key = ENV['cloudinary_api_key']
    config.api_secret = ENV['cloudinary_api_secret']
  end
end

if Cloudinary.config.api_key.blank?
  puts
  puts "Please configure this demo to use your Cloudinary account"
  puts "by copying configuration values from the Management Console"
  puts "at https://cloudinary.com/console into config.rb."
  puts
  exit
end

puts "* Uploading sample image files, please wait..."

uploads = {}

Dir.children("assets").each do |file|
  uploads[:"#{file}"] = Cloudinary::Uploader.upload "assets/#{file}",
  :tags => "website_assets",
  :folder => "website_assets",
  :public_id => "#{File.basename(file,File.extname(file))}" unless file == 'img'
end

puts "* Done."

puts
puts "* #{uploads.length} images were uploaded and are now available in the cloud."
uploads.each_value.with_index do |upload, index|
  puts "> Upload \##{index+1}:"
  puts "  Public ID: #{upload['public_id']}"
  puts "  URL: #{upload['url']}"
end
