require 'rails_helper'

RSpec.describe Api::V1::TournamentsController, type: :controller do
  describe "GET #match" do
    before do
      csv_file_path = fixture_file_upload("files/tournament 10 ball.csv")
      Tournament.import_tournament_from_csv(csv_file_path)
    end
    it "returns a success response" do
      get :matches, params: {tournament_name: "Tournament 10 ball"}, format: :json
      expect(response).to be_success
    end

    it "returns a success response" do
      get :matches, params: {player_name: "Elon Musk"}, format: :json
      expect(response).to be_success
    end

    it "returns a fail response" do
      get :matches, params: {}, format: :json
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET #statistical" do
    before do
      csv_file_path = fixture_file_upload("files/tournament 10 ball.csv")
      Tournament.import_tournament_from_csv(csv_file_path)
    end
    it "returns a success response" do
      get :statistical, params: {id: 1, player_name: "Elon Musk"}, format: :json
      expect(response).to be_success
    end

    it "returns a success response" do
      get :statistical, params: {player_name: "Elon Musk"}, format: :json
      expect(response).to be_success
    end

    it "returns a fail response" do
      get :statistical, params: {}, format: :json
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "POST #import" do
    context "with valid params" do
      it "import success a new Tournament" do
        csv_file_path = fixture_file_upload("files/tournament 10 ball.csv","text/csv")
        expect {
          post :import, params: {file: csv_file_path}, format: :json
        }.to change(Tournament, :count).by(1)
      end

      it "renders success message" do
        csv_file_path = fixture_file_upload("files/tournament 10 ball.csv", "text/csv")
        post :import, params: {file: csv_file_path}, format: :json
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)["message"]).to eq("Your CSV file has been succesfully imported")
      end
    end

    context "with invalid params" do
      it "renders a error message" do
        post :import, params: {}, format: :json
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
