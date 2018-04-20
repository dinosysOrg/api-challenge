require 'rails_helper'

RSpec.describe Result, type: :model do
  it "result point csv" do
    csv_file_path = fixture_file_upload("tournament 10 ball.csv")
    Tournament.import_tournament_from_csv(csv_file_path)

    player_1_id = Player.find_by_name("Mark Zuckerberg").id
    player_2_id = Player.find_by_name("Diane Greene").id

    match_id = Match.search(player_1_id, player_2_id)
    results = Result.where(match_id: match_id)

    expect(results[0].point).to eq(3)
    expect(results[0].score).to eq(nil)

    expect(results[1].point).to eq(0)
    expect(results[1].score).to eq(nil)
  end

  it "player 1 win" do
    csv_file_path = fixture_file_upload("tournament 10 ball.csv")
    Tournament.import_tournament_from_csv(csv_file_path)

    player_1_id = Player.find_by_name("Elon Musk").id
    player_2_id = Player.find_by_name("Liam Wong").id
    results = Result.where(match_id: Match.search(player_1_id, player_2_id))
    expect(results[0].point).to eq(3)
    expect(results[0].score).to eq(6)

    expect(results[1].point).to eq(0)
    expect(results[1].score).to eq(4)
  end

  it "draw" do
    csv_file_path = fixture_file_upload("tournament 10 ball.csv")
    Tournament.import_tournament_from_csv(csv_file_path)

    player_1_id = Player.find_by_name("Mark Zuckerberg").id
    player_2_id = Player.find_by_name("Ruth Porat").id
    results = Result.where(match_id: Match.search(player_1_id, player_2_id))
    expect(results[0].point).to eq(1)
    expect(results[0].score).to eq(5)

    expect(results[1].point).to eq(1)
    expect(results[1].score).to eq(5)
  end

  it "player 1 gave up" do
    csv_file_path = fixture_file_upload("tournament 10 ball.csv")
    Tournament.import_tournament_from_csv(csv_file_path)

    player_1_id = Player.find_by_name("Diane Greene").id
    player_2_id = Player.find_by_name("Ruth Porat").id

    results = Result.where(match_id: Match.search(player_1_id, player_2_id))

    expect(results[0].point).to eq(0)
    expect(results[0].score).to eq(nil)

    expect(results[1].point).to eq(3)
    expect(results[1].score).to eq(nil)
  end

  it "player 2 win" do
    csv_file_path = fixture_file_upload("tournament 10 ball.csv")
    Tournament.import_tournament_from_csv(csv_file_path)

    player_1_id = Player.find_by_name("Nathan Blecharczyk").id
    player_2_id = Player.find_by_name("Brian Chesky").id

    results = Result.where(match_id: Match.search(player_1_id, player_2_id))

    expect(results[0].point).to eq(0)
    expect(results[0].score).to eq(4)

    expect(results[1].point).to eq(3)
    expect(results[1].score).to eq(6)
  end
end
