require 'rails_helper'

RSpec.describe Api::V1::MatchController, type: :controller do
  describe "GET #get_list" do
    before(:each) do
      create :tournament
      create :group
      create :venue
      create :user, :player_mz
      create :user, :player_cc
      create :user, :player_jd
      create :match, :mz_gave_up
      create :match, :player_jd_and_cc_drawn
    end

    it "when not matching with input search_string" do
      get :get_list, params: {search_string: "Test"}
      expect(response).to have_http_status(:not_found)
    end

    it "Search by tournament" do
      get :get_list, params: {search_string: "Tournament 1"}
      resp_body = Oj.load response.body
      expect(resp_body["data"].count).to eq(2)
      expect(response).to have_http_status(:success)
    end

    it "Search by username" do
      get :get_list, params: {search_string: "Mark Zuckerberg"}
      resp_body = Oj.load response.body
      expect(resp_body["data"].count).to eq(1)
      expect(response).to have_http_status(:success)
    end
  end
end
