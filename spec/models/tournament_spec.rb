require 'rails_helper'

RSpec.describe Tournament, type: :model do
  it "import csv" do
    csv_file_path = fixture_file_upload("files/tournament 10 ball.csv")
    Tournament.import_tournament_from_csv(csv_file_path)
    expect(Match.find_by(code: "C1-2-3").results[0].player.name).to eq("Diane Greene")
    expect(Match.find_by(code: "C2-1-2").venue).to eq("Carmen")
  end
end
