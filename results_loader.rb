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
        teams = []
        row.each do |cell|
          unless cell.nil? || cell.empty?
            teams << cell
            raise "Team #{cell} is not valid" unless @teams_loader.valid? cell
          end
        end

        raise "Round #{@results.count + 1} has #{teams.count} teams and was expecting #{teams_count}" unless teams.count == teams_count

        @results << teams
        teams_count = teams_count / 2
      end
    else
      results.each_line do |line|
        CSV.parse(line) do |row|
          teams = []
          row.each do |cell|
            unless cell.nil? || cell.empty?
              teams << cell
              raise "Team #{cell} is not valid" unless @teams_loader.valid? cell
            end
          end

          raise "Round #{@results.count + 1} has #{teams.count} teams and was expecting #{teams_count}" unless teams.count == teams_count

          @results << teams
          teams_count = teams_count / 2
        end
      end
    end

    raise "Your results file has #{@results.count} lines and was expecting #{rounds_count}" unless @results.count == 6
  end
end