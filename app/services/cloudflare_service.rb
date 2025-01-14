require 'httparty'

class CloudflareService
  include HTTParty
  base_uri 'https://api.cloudflare.com/client/v4'

  def initialize
    @headers = {
      "X-Auth-Email" => ENV['CLOUDFLARE_EMAIL'],
      "X-Auth-Key" => ENV['CLOUDFLARE_GLOBAL_API_KEY'],
      "Content-Type" => "application/json"
    }
    Rails.logger.debug "Headers being sent: #{@headers.inspect}"

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
  def start_recording(input_id)
    put_live_input(input_id, { recording: { mode: "automatic" } })
  end

  def stop_recording(input_id)
    put_live_input(input_id, { recording: { mode: "off" } })
  end

  def list_recordings(input_id)
    account_id = ENV['CLOUDFLARE_ACCOUNT_ID']
    url = "/accounts/#{account_id}/stream"
    response = self.class.get(url, headers: @headers)

    Rails.logger.debug "Cloudflare GET Recordings Response Code: #{response.code}"
    Rails.logger.debug "Cloudflare GET Recordings Response Body: #{response.body}"

    if response.success?
      videos = JSON.parse(response.body)["result"]
      # Filtrer les vidéos associées à l'input_id
      videos.select { |video| video["liveInput"] == input_id }
    else
      []
    end
  end




  private

  def put_live_input(input_id, body)
    account_id = ENV['CLOUDFLARE_ACCOUNT_ID']
    url = "/accounts/#{account_id}/stream/live_inputs/#{input_id}"
    response = self.class.put(url, headers: @headers, body: body.to_json)

    Rails.logger.debug "Cloudflare PUT Response Code: #{response.code}"
    Rails.logger.debug "Cloudflare PUT Response Body: #{response.body}"

    response
  end

end
