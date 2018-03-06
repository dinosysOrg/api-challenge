require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test 'test statistic of player' do
    best_player_statistic = Player.find(2).statistic(1) # tournament id is 1
    assert best_player_statistic['total_points'] == 4
    assert best_player_statistic['wins'] == 1
    assert best_player_statistic['looses'].zero?
    assert best_player_statistic['draws'] == 1
  end


  test 'filter matches of player' do
    player1 = Player.find(1)
    player2 = Player.find(2)

    assert player1.filter_matches(1).size == 2
    assert player2.filter_matches(1).size == 2
    assert player1.filter_matches.size == 2
    assert player2.filter_matches.size == 2
    matches = player1.filter_matches
    # test info of match
    first_match = matches.detect { |m| m.id == 1 }
    assert first_match.player_1_goals == 1
    assert first_match.player_2_goals == 1
  end
end
