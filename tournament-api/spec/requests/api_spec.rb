require "rails_helper"

RSpec.describe "Tournament API", :type => :request do
  subject { '%{JSON_WITH_ARRAY}' }

  before :each do
    csv_file_path = file_fixture("calculate point test.csv")
    params =
      {
        params:
          {
            file: Rack::Test::UploadedFile.new(csv_file_path, 'text/csv')
          }
      }
    post "/tournaments/import", params
  end

  it "get matches by player name" do
    get "/api/v1/matches", params: { player: "Lary Page" }
    matches_response = file_fixture("response/matches-player-name.json").read
    expect(JSON.parse(response.body)).to include_json JSON.parse(matches_response)
  end

  it "get then get matches by tournament name" do
    get "/api/v1/matches", params: { tournament: "Calculate point test" }
    matches_response = file_fixture("response/matches-tournament-name.json").read
    expect(JSON.parse(response.body)).to include_json JSON.parse(matches_response)
  end

  it "get points and number of won matches, lost matches, drawn matches by player name" do
    get "/api/v1/statistical", params: { player: "Elon Musk" }
    matches_response = file_fixture("response/points.json").read
    expect(JSON.parse(response.body)).to include_json JSON.parse(matches_response)
  end
end