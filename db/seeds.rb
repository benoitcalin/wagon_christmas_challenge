# require "uri"
# require "net/http"

# url = URI(ENV["CHALLENGE_URL"])

# https = Net::HTTP.new(url.host, url.port);
# https.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["Cookie"] = "session=#{ENV["COOKIE_SESSION"]}"
# response = https.request(request)

# hash = JSON.parse(response.body)

# # hash = {"event"=>"2020", "owner_id"=>"1237086", "members"=>{"1222761"=>{"local_score"=>4, "stars"=>2, "id"=>"1222761", "name"=>"Pierre-Loïc", "last_star_ts"=>"1607502335", "global_score"=>0, "completion_day_level"=>{"9"=>{"2"=>{"get_star_ts"=>"1607502335"}, "1"=>{"get_star_ts"=>"1607500726"}}}}, "1237086"=>{"stars"=>4, "local_score"=>4, "id"=>"1237086", "global_score"=>0, "completion_day_level"=>{"2"=>{"2"=>{"get_star_ts"=>"1607448083"}, "1"=>{"get_star_ts"=>"1607447326"}}, "1"=>{"2"=>{"get_star_ts"=>"1607445635"}, "1"=>{"get_star_ts"=>"1607445373"}}}, "name"=>"Pilou69", "last_star_ts"=>"1607448083"}}}

# members_array = []
# hash['members'].each { |key, value| members_array << value }

# day_hash = {}
# for i in (1..25) do
#   day_hash["#{i}-1"] = []
#   day_hash["#{i}-2"] = []
# end

# members_array.each do |member|
#   member['completion_day_level'].each do |day, challenges|
#     day_hash[day + "-1"] << { member['id'] => challenges["1"]["get_star_ts"] } if challenges["1"]
#     day_hash[day + "-2"] << { member['id'] => challenges["2"]["get_star_ts"] } if challenges["2"]
#   end
# end

# scores = {}

# day_hash.each do |challenge_nbr, participants|
#   # p_length = participants.length
#   p_length = 10
#   participants.sort_by { |participant| participant['value'] }.each_with_index do |part, index|
#     if scores[part.keys.first]
#       scores[part.keys.first] += p_length - index
#     else
#       scores[part.keys.first] = p_length - index
#     end
#   end
# end

# pp scores

GetResultsService.call
