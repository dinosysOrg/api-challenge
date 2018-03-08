require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

  # test statistic of tournament
  test 'test statistic of tournament' do
    statistic = Tournament.first.statistic
    assert statistic.size == 2
    best_player = statistic.detect { |p| p['id'] == 2 }
    assert best_player['total_points'] == 4
    assert best_player['wins'] == 1
    assert best_player['looses'].zero?
    assert best_player['draws'] == 1
    assert statistic.detect { |p| p['id'] == 1 }['total_points'] == 1
  end



end
