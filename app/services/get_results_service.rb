require "uri"
require "net/http"

module GetResultsService
  class << self
    def call
      url = URI(ENV["CHALLENGE_URL"])

      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Cookie"] = "session=#{ENV["COOKIE_SESSION"]}"
      response = https.request(request)

      json = JSON.parse(response.body)

      get_results_array(json)
    end

    private

    def get_results_array(json)
      members_array = []
      json['members'].each { |key, value| members_array << value }


      members_array.each do |member|
        member['completion_day_level'].each do |day, challenges|
          day_hash[day + "-1"] << { member['id'] => challenges["1"]["get_star_ts"] }
          day_hash[day + "-2"] << { member['id'] => challenges["2"]["get_star_ts"] }

        end
      end

      scores = {}

      day_hash.each do |challenge_nbr, participants|
        # p_length = participants.length
        p_length = 10
        participants.sort_by { |participant| participant['value'] }.each_with_index do |part, index|
          if scores[part.keys.first]
            scores[part.keys.first] += p_length - index
          else
            scores[part.keys.first] = p_length - index
          end
        end
      end

      pp scores
    end

  end
end
