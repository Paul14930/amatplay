# app/services/cloudflare_image_uploader.rb
require 'httparty'

class CloudflareImageUploader
  CLOUDFLARE_API_URL = "https://api.cloudflare.com/client/v4/accounts/#{ENV['CLOUDFLARE_ACCOUNT_ID']}/images/v1"

  def self.upload_image(file)
    response = HTTParty.post(
      CLOUDFLARE_API_URL,
      headers: {
        "Authorization" => "Bearer #{ENV['CLOUDFLARE_API_TOKEN']}"
      },
      body: {
        file: file
      }
    )
    JSON.parse(response.body)
  end
end
