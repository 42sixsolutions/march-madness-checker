require 'net/http'

require './teams_loader.rb'
require './results_loader.rb'
require './score_loader.rb'

actual_results_input_file_or_url = ARGV[0]
puts "Using #{actual_results_input_file_or_url} as the actual results input file"
actual_results_loader = (actual_results_input_file_or_url.starts_with? 'http') ?
    ResultsLoader.new(actual_results_input_file_or_url) :
    ResultsLoader.new(actual_results_input_file_or_url, false)

contestant_results_input_file__or_url = ARGV[1]
puts "Using #{contestant_results_input_file__or_url} as the contestant results input file"
contestant_results_input_file = Net::HTTP.get(contestant_results_input_file__or_url)

actual_results_loader = ResultsLoader.new actual_results_input_file
contestant_results_loader = ResultsLoader.new contestant_results_input_file

score_loader = ScoreLoader.new actual_results_loader.results, contestant_results_loader.results
puts "Score was #{score_loader.score}"