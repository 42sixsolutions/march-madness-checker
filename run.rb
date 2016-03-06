require 'net/http'

require './teams_loader.rb'
require './results_loader.rb'
require './score_loader.rb'

actual_results_input_file_or_url = ARGV[0]
puts "Using #{actual_results_input_file_or_url} as the actual results input file"
actual_results_loader = (actual_results_input_file_or_url.start_with? 'http') ?
    ResultsLoader.new(Net::HTTP.get(URI actual_results_input_file_or_url), false) :
    ResultsLoader.new(actual_results_input_file_or_url)

contestant_results_input_file_or_url = ARGV[1]
puts "Using #{contestant_results_input_file_or_url} as the contestant results input file"
contestant_results_loader = (contestant_results_input_file_or_url.start_with? 'http') ?
    ResultsLoader.new(Net::HTTP.get(URI contestant_results_input_file_or_url), false) :
    ResultsLoader.new(contestant_results_input_file_or_url)

score_loader = ScoreLoader.new actual_results_loader.results, contestant_results_loader.results
puts "Score was #{score_loader.score}"