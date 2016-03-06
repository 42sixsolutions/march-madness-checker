require 'net/http'

require './teams_loader.rb'
require './results_loader.rb'
require './score_loader.rb'

team_loader = TeamsLoader.new()
raise "Teams did not load input file" if team_loader.teams.empty?

raise "Did not validated a valid team" unless team_loader.valid? "West Virginia"
raise "Validated an invalid team" if team_loader.valid? "Invalid Team"

raise "Did not validated a valid list of teams" unless team_loader.valid? ["West Virginia", "Virginia", "Maryland"]
raise "Validated a list of teams with an invalid team" if team_loader.valid? ["West Virginia", "Virginia", "Invalid Team", "Maryland"]

results_loader = ResultsLoader.new 'valid_results_sample_file.csv'
raise "Results did not load input file" if results_loader.results.empty?

results_loader2 = ResultsLoader.new Net::HTTP.get(URI 'https://raw.githubusercontent.com/42sixsolutions/march-madness/master/results-sample.csv'), false
raise "Results did not load input file" if results_loader2.results.empty?

score_loader = ScoreLoader.new results_loader.results, results_loader2.results
puts score_loader.score

puts 'Tests Passed'