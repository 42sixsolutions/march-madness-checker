class ScoreLoader
  attr :score
  def initialize(actual_results, contestant_results)
    @score = 0
    round_score = 1

    actual_results.each_with_index do |round, i|
      round.each_with_index do |team, j|
        @score = @score + round_score if team == contestant_results[i][j]
      end

      puts "Round: #{i + 1}   Round Score: #{round_score}   Score: #{score}"

      round_score = round_score * 2
    end

    @score
  end
end