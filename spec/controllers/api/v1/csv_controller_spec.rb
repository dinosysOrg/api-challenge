require 'rails_helper'

RSpec.describe Api::V1::CsvController, type: :controller do
  before(:all) do
    file_path = file_fixture("tournament.csv")
    @csv_file = Rack::Test::UploadedFile.new(file_path, "text/csv")
    @wrong_file_type = Rack::Test::UploadedFile.new(file_path, "text/txt")
  end

  describe "POST #import" do
    it "Input wrong, File type should be csv" do
      post :import, params: {csv: {file: @wrong_file_type}}
      expect(response).to have_http_status(:unsupported_media_type)
    end

    it "returns http success" do
      post :import, params: {csv: {file:  @csv_file}}
      _tournament = Tournament.count
      _group      = Group.count
      _venue      = Venue.count
      _user       = User.count
      _match      = Match.count

      expect(_tournament).to eq(1)
      expect(_group).to eq(1)
      expect(_venue).to eq(2)
      expect(_user).to eq(3)
      expect(_match).to eq(3)
      expect(response).to have_http_status(:success)
    end
  end

end
