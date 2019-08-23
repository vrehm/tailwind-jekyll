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

def self.exists?(public_id, options={})
  cloudinary_url = Cloudinary::Utils.cloudinary_url(public_id, options)
  begin
    code = RestClient::Request.execute(:method => :head, :url => cloudinary_url, :timeout =>     5).code
    code >= 200 && code < 300
    rescue RestClient::ResourceNotFound
    return false
  end
end

puts "* Uploading assets image files, please wait..."

uploads = {}

Dir.children("assets").each do |file|
  next if file == 'img'
  public_id = File.basename(file,File.extname(file))
  unless Cloudinary::Uploader.exists?(public_id)
    uploads[:"#{file}"] = Cloudinary::Uploader.upload "assets/#{file}",
    :tags => "web_assets",
    :folder => "web_assets",
    :public_id => public_id
  end
end

puts "* Done."

if uploads.length == 0
  puts "Everything is already on the cloud."
else
  puts "* #{uploads.length} images were uploaded and are now available in the cloud."
  uploads.each_value.with_index do |upload, index|
    puts "> Upload \##{index+1}:"
    puts "  Public ID: #{upload['public_id']}"
    puts "  URL: #{upload['url']}"
  end
end
