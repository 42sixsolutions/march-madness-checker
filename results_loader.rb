require 'CSV'
require './teams_loader.rb'

class ResultsLoader
  attr :results, :teams_loader

  def initialize(results = 'results_sample_file.csv', is_a_file = true)
    @teams_loader = TeamsLoader.new()
    @results = []
    rounds_count = 6
    teams_count = 32

    if is_a_file
      CSV.foreach(results) do |row|
        raise "Round #{@results.count + 1} has #{row.count} teams and was expecting #{teams_count}" unless row.count == teams_count

        row.each do |cell|
          raise "Team #{cell} is not valid" unless @teams_loader.valid? cell
        end

        @results << row
        teams_count = teams_count / 2
      end
    else
      results.each_line do |line|
        CSV.parse(line) do |row|
          raise "Round #{@results.count + 1} has #{row.count} teams and was expecting #{teams_count}" unless row.count == teams_count

          row.each do |cell|
            raise "Team #{cell} is not valid" unless @teams_loader.valid? cell
          end

          @results << row
        end

        teams_count = teams_count / 2
      end
    end

    raise "Your results file has #{@results.count} lines and was expecting #{rounds_count}" unless @results.count == 6
  end
end