require 'httparty'

class CloudflareService
  include HTTParty
  base_uri 'https://api.cloudflare.com/client/v4'

  def initialize
    @headers = {
      "Authorization" => "Bearer #{ENV['CLOUDFLARE_API_TOKEN']}",
      "Content-Type" => "application/json"
    }
  end

  # Créer un flux RTMP unique
  def create_live_input(name)
    body = {
      input: {
        type: "rtmp",
        name: name
      }
    }
    self.class.post('/accounts/d3270f1852f619d372410867a8b68523/stream/live_inputs', headers: @headers, body: body.to_json)
  end

  # Obtenir les détails d’un flux
  def get_live_input(input_id)
    self.class.get("/accounts/d3270f1852f619d372410867a8b68523/stream/live_inputs/#{input_id}", headers: @headers)
  end
end
