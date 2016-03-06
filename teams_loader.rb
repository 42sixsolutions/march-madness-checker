require 'CSV'

class TeamsLoader
  attr :teams

  def initialize(input_file = 'teams_input_file.csv')
    @teams = {}

    CSV.foreach(input_file) do |row|
      @teams[row[0].strip] = true
    end
  end

  def valid?(team_or_teams)
    [*team_or_teams].each do  |team|
      return false unless @teams.include? team.strip
    end
    true
  end
end