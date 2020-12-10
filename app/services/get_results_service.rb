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

      @json = JSON.parse(response.body)

      get_results_array()
    end

    private

    def get_results_array
      create_members_array()
      create_results_by_challenge(1)
      fill_results_by_challenge()
      get_scores_by_member()
    end

    def create_members_array
      @members_array = []
      @json['members'].each { |key, value| @members_array << value }
    end

    def create_results_by_challenge(start_day)
      @results_by_challenge = {}
      for i in (start_day..25) do
        @results_by_challenge["#{i}-1"] = []
        @results_by_challenge["#{i}-2"] = []
      end
    end

    def fill_results_by_challenge
      @members_array.each do |member|
        member['completion_day_level'].each do |day, challenges|
          @results_by_challenge[day + "-1"] << { member['id'] => challenges["1"]["get_star_ts"] } if challenges["1"]
          @results_by_challenge[day + "-2"] << { member['id'] => challenges["2"]["get_star_ts"] } if challenges["2"]
        end
      end
    end

    def get_scores_by_member
      scores = {}
      @results_by_challenge.each do |challenge_nbr, participants|
        p_length = User.count
        participants.sort_by { |participant| participant['value'] }.each_with_index do |part, index|
          if scores[part.keys.first]
            scores[part.keys.first] += p_length - index
          else
            scores[part.keys.first] = p_length - index
          end
        end
      end
      scores
    end
  end
end
