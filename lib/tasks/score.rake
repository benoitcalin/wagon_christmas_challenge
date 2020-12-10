require "uri"
require "net/http"

namespace :score do
  desc "Recompute scores"
  task compute: :environment do
    # ----------------------------------------------- #
    # STEP 1: Retrieve json from official leaderboard #
    # ----------------------------------------------- #

    url = URI(ENV["CHALLENGE_URL"])

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Cookie"] = "session=#{ENV['COOKIE_SESSION']}"
    response = https.request(request)

    @json = JSON.parse(response.body)
    # @json = JSON.parse('{"event":"2020","owner_id":"1237086","members":{"1095582":{"id":"1095582","last_star_ts":"1607612317","completion_day_level":{"1":{"1":{"get_star_ts":"1607603169"},"2":{"get_star_ts":"1607603218"}},"2":{"1":{"get_star_ts":"1607604144"},"2":{"get_star_ts":"1607605412"}},"3":{"1":{"get_star_ts":"1607610758"},"2":{"get_star_ts":"1607610964"}},"4":{"1":{"get_star_ts":"1607612317"}}},"stars":7,"global_score":0,"name":"Benoit Calin","local_score":28},"1237086":{"id":"1237086","last_star_ts":"1607448083","completion_day_level":{"1":{"1":{"get_star_ts":"1607445373"},"2":{"get_star_ts":"1607445635"}},"2":{"1":{"get_star_ts":"1607447326"},"2":{"get_star_ts":"1607448083"}}},"stars":4,"global_score":0,"name":"Pilou69","local_score":12},"1258899":{"name":"Geoffrey-Dulac","local_score":0,"id":"1258899","last_star_ts":0,"completion_day_level":{},"global_score":0,"stars":0},"1259034":{"id":"1259034","last_star_ts":0,"completion_day_level":{},"stars":0,"global_score":0,"name":"Marceau TASSIN","local_score":0},"1259062":{"local_score":23,"name":"Carine Le Charlès","global_score":0,"stars":7,"completion_day_level":{"1":{"1":{"get_star_ts":"1607612542"},"2":{"get_star_ts":"1607613488"}},"2":{"1":{"get_star_ts":"1607614795"},"2":{"get_star_ts":"1607616027"}},"3":{"1":{"get_star_ts":"1607625907"},"2":{"get_star_ts":"1607626215"}},"4":{"1":{"get_star_ts":"1607627137"}}},"last_star_ts":"1607627137","id":"1259062"},"1259379":{"name":"Alexis Filia","local_score":0,"completion_day_level":{},"global_score":0,"stars":0,"id":"1259379","last_star_ts":0}}}')

    # pp @json["members"]

    # -------------------------------------------------------- #
    # STEP 2: Build Hash with ranked IDs per challenge per day #
    # -------------------------------------------------------- #
    # [{"1"=>
    #   {"1"=>["1237086", "1095582", "1259062"],
    #    "2"=>["1237086", "1095582", "1259062"]}},
    # {"2"=>
    #   {"1"=>["1237086", "1095582", "1259062"],
    #    "2"=>["1237086", "1095582", "1259062"]}
    # }]

    DAYS = ("1".."25")
    CHALLENGES = ["1", "2"]

    daily_results = []

    DAYS.each do |day|
      this_day = {}

      CHALLENGES.each do |challenge|
        this_challenge = {}

        @json["members"].each do |aoc_id, stats|
          this_challenge[aoc_id] = stats.dig("completion_day_level", day, challenge, "get_star_ts").to_i
        end

        this_day[challenge] = this_challenge
          .select { |aoc_id, time| time != 0} # Ignore when not resolved
          .sort_by { |aoc_id, time| time }    # Sort by time of resolution (the earlier the better)
          .map { |array_| array_[0] }         # Keep only the AOC ID
      end

      daily_results << { day => this_day }
    end

    # pp daily_results

    # -------------------------------- #
    # STEP 3: Build individual ranking #
    # -------------------------------- #
    # {
    #   username: "toto",
    #   batch: "345",
    #   score_11: 12,
    #   # ...
    #   score_25: 0,
    #   score_total: 15
    # }

    N_PLAYERS = User.count

    individual_ranking = []

    User.all.each do |user|
      user_score = {
        username: user.pseudo,
        batch: user.batch.short_name
      }
      score_total = 0

      daily_results.each do |day|
        challenges = day.values[0]
        daily_score = 0
        
        challenges.each do |challenge, players|
          next if players.index(user.challenger_id).nil?

          daily_score += N_PLAYERS - players.index(user.challenger_id)
        end

        user_score["score_#{day.keys[0]}".to_sym] = daily_score
        score_total += daily_score
      end

      user_score[:score_total] = score_total
      individual_ranking << user_score
    end

    pp individual_ranking

    # --------------------------- #
    # STEP 4: Build batch ranking #
    # --------------------------- #
    # {
    #   batch: "345",
    #   score_11: 12,
    #   bonus_11: 0,
    #   # ...
    #   score_25: 0,
    #   bonus_25: 0,
    #   score_total: 15
    # }

    N_BATCHES = Batch.count

    batch_ranking = []

    Batch.all.each do |batch|
      batch_score = {
        batch: batch.short_name
      }
      score_total = 0

      daily_results.each do |day|
        challenges = day.values[0]
        daily_score = 0
        daily_bonus = 0

        challenges.each do |challenge, players|
          batches = players
            .select { |aoc_id| User.find_by(challenger_id: aoc_id) }
            .map { |aoc_id| User.find_by(challenger_id: aoc_id).batch.short_name }

          next if batches.index(batch.short_name).nil?

          daily_bonus += 5 if batches.count(batch.short_name) >= 5
          daily_score += N_BATCHES - batches.uniq.index(batch.short_name)
        end

        batch_score["score_#{day.keys[0]}".to_sym] = daily_score
        batch_score["bonus_#{day.keys[0]}".to_sym] = daily_bonus
        score_total += daily_score + daily_bonus
      end

      batch_score[:score_total] = score_total

      batch_ranking << batch_score
    end

    pp batch_ranking

    # ----------------------------- #
    # STEP 5: Update ranking tables #
    # ----------------------------- #

    # TODO...
  end
end
