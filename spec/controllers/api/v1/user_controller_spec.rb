require 'rails_helper'

RSpec.describe Api::V1::UserController, type: :controller do
  describe "GET #player_results" do
    before(:each) do
      create :tournament
      create :group
      create :venue
      create :user, :player_mz
      create :user, :player_cc
      create :match, :mz_gave_up
    end

    it "when not matching with input username" do
      get :player_results, params: {username: "Test"}
      expect(response).to have_http_status(:not_found)
    end

    context "When player gave up" do
      it "when player gave up" do
        get :player_results, params: {username: "Mark Zuckerberg"}
        resp_body = Oj.load response.body
        expect(resp_body["data"]["matchs_result"]["lost"]).to eq(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "When no gave up" do
      before(:each) do
        create :match, :player_mz_win
        create :match, :player_mz_lost
        create :match, :drawn
      end

      it "when player win" do
        get :player_results, params: {username: "Mark Zuckerberg"}
        resp_body = Oj.load response.body
        expect(resp_body["data"]["matchs_result"]["won"]).to eq(1)
        expect(response).to have_http_status(:ok)
      end

      it "when player losing" do
        get :player_results, params: {username: "Mark Zuckerberg"}
        resp_body = Oj.load response.body
        expect(resp_body["data"]["matchs_result"]["lost"]).to eq(2)
        expect(response).to have_http_status(:ok)
      end

      it "when player dramn" do
        get :player_results, params: {username: "Mark Zuckerberg"}
        resp_body = Oj.load response.body
        expect(resp_body["data"]["matchs_result"]["drawn"]).to eq(1)
        expect(response).to have_http_status(:ok)
      end
    end

  end
end
