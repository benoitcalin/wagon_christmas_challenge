require "uri"
require "net/http"

module GetResultsService
  class << self
    def call
      # url = URI(ENV["CHALLENGE_URL"])

      # https = Net::HTTP.new(url.host, url.port);
      # https.use_ssl = true

      # request = Net::HTTP::Get.new(url)
      # request["Cookie"] = "session=#{ENV['COOKIE_SESSION']}"
      # response = https.request(request)

      # @json = JSON.parse(response.body)

      # @json = {"members"=>{"1237086"=>{"global_score"=>0, "stars"=>4, "name"=>"Pilou69", "id"=>"1237086", "last_star_ts"=>"1607448083", "local_score"=>4, "completion_day_level"=>{"2"=>{"2"=>{"get_star_ts"=>"1607448083"}, "1"=>{"get_star_ts"=>"1607447326"}}, "1"=>{"2"=>{"get_star_ts"=>"1607445635"}, "1"=>{"get_star_ts"=>"1607445373"}}}}, "1222761"=>{"stars"=>4, "global_score"=>0, "id"=>"1222761", "name"=>"Pierre-Loïc", "last_star_ts"=>"1607590765", "local_score"=>8, "completion_day_level"=>{"10"=>{"1"=>{"get_star_ts"=>"1607585877"}, "2"=>{"get_star_ts"=>"1607590765"}}, "9"=>{"2"=>{"get_star_ts"=>"1607502335"}, "1"=>{"get_star_ts"=>"1607500726"}}}}}, "owner_id"=>"1237086", "event"=>"2020"}

      @json = {"members"=>
                {"1237086"=>
                  {"global_score"=>0,
                  "stars"=>4,
                  "name"=>"Pilou69",
                  "id"=>"1237086",
                  "last_star_ts"=>"1607448083",
                  "local_score"=>4,
                  "completion_day_level"=>
                    {"2"=>
                      {"2"=>{"get_star_ts"=>"1607448083"},
                      "1"=>{"get_star_ts"=>"1607447326"}},
                    "1"=>
                      {"2"=>{"get_star_ts"=>"1607445635"},
                      "1"=>{"get_star_ts"=>"1607445373"}}}},
                "1222761"=>
                  {"stars"=>4,
                  "global_score"=>0,
                  "id"=>"1222761",
                  "name"=>"Pierre-Loïc",
                  "last_star_ts"=>"1607590765",
                  "local_score"=>8,
                  "completion_day_level"=>
                    {
                      "10"=>
                        {"1"=>{"get_star_ts"=>"1607585877"},
                        "2"=>{"get_star_ts"=>"1607590765"}},
                      "9"=>
                        {
                          "2"=>{"get_star_ts"=>"1607502335"},
                          "1"=>{"get_star_ts"=>"1607500726"}
                        },
                      "2"=>
                        {"2"=>{"get_star_ts"=>"1607448085"},
                        "1"=>{"get_star_ts"=>"1607447312"}},
                      "1"=>
                        {"2"=>{"get_star_ts"=>"1607445685"},
                        "1"=>{"get_star_ts"=>"1607445312"}}
                    }
                  }
                    },
              "owner_id"=>"1237086",
              "event"=>"2020"}

      Result.destroy_all
      get_results_array
    end

    private

    def get_results_array
      create_members_array
      create_results
      calculate_users_scores
      # calculate_batches_scores
    end

    def create_members_array
      @members_array = []
      @json['members'].each { |_key, value| @members_array << value }
    end

    def create_results
      @members_array.each do |member|
        user = User.find_by_challenger_id(member['id'])
        member['completion_day_level'].each do |day, challenges|
          challenges.each do |number, challenge_result|
            challenge = Challenge.where('day = ? AND number = ?', day, number).first
            Result.create!(user: user, challenge: challenge, end_time: challenge_result["get_star_ts"]) if challenge
          end
        end
      end
    end

    def calculate_users_scores
      Challenge.all.each do |challenge|
        unless challenge.results.empty?
          challenge.results.order(end_time: 'DESC').each_with_index do |result, index|
            count = User.count
            result.update(score: count - index)
          end
        end
      end
    end


  end
end
