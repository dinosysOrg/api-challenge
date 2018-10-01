require 'rails_helper'

RSpec.describe Api::V1::CsvController, type: :controller do
  before(:each) do
    file_path = file_fixture("tournament.csv")
    @csv_file = Rack::Test::UploadedFile.new(file_path, "text/csv")
    @wrong_file_type = Rack::Test::UploadedFile.new(file_path, "text/txt")
  end

  describe "POST #import" do
    it "Input wrong, File type should be csv" do
      post :import, params: {csv: {file: @wrong_file_type}}
      expect(response).to have_http_status(:unsupported_media_type)
    end

    it "CSV import process" do
      post :import, params: {csv: {file:  @csv_file}}
      expect(response).to have_http_status(:success)
    end
  end

end
