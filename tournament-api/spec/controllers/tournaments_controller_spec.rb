require 'rails_helper'
require 'csv'

RSpec.describe TournamentsController, type: :controller do
  it "calculate point" do
    csv_file_path = file_fixture("calculate point test.csv")
    params =
      {
        params:
          {
            file: Rack::Test::UploadedFile.new(csv_file_path, 'text/csv')
          }
      }
    post :import, params
    expect(Match.find_by(name: "C1-2-3").take_place_matches.pluck(:point)).to contain_exactly(3, 0)
    expect(Match.find_by(name: "C2-1-2").take_place_matches.pluck(:point)).to contain_exactly(1, 1)
    expect(Match.find_by(name: "C2-1-3").take_place_matches.pluck(:point)).to contain_exactly(3, 0)
    expect(Match.find_by(name: "C2-1-3").take_place_matches.pluck(:point)).to contain_exactly(0, 3)
  end
end