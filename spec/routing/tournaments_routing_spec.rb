require "rails_helper"

RSpec.describe Api::V1::TournamentsController, type: :routing do
  describe "routing" do

    it "routes to #matches" do
      expect(get: "api/v1/tournaments/matches").to route_to("api/v1/tournaments#matches")
    end

    it "routes to #statistical" do
      expect(get: "api/v1/tournaments/statistical").to route_to("api/v1/tournaments#statistical")
    end

    it "routes to #import" do
      expect(post: "api/v1/tournaments/import").to route_to("api/v1/tournaments#import")
    end
  end
end
