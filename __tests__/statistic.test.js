const path = require("path");
const qs = require("querystring");
const { isArray } = require("lodash");
const supertest = require("supertest");

const app = require("../src");

describe("Query statistics", () => {
  it("should statistics by player name", async () => {
    const playerName = "Mark Zuckerberg";
    const { body } = await supertest(app)
      .get(`/statistics?${qs.stringify({ playerName })}`)
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200);

    const {
      failedToStat,
      points,
      won_matches,
      lost_matches,
      drawn_matches
    } = body.data;

    expect(failedToStat.length).toBeFalsy();
    expect(Number(points) === Number(points)).toBeTruthy();
    expect(Number(won_matches) === Number(won_matches)).toBeTruthy();
    expect(Number(lost_matches) === Number(lost_matches)).toBeTruthy();
    expect(Number(drawn_matches) === Number(drawn_matches)).toBeTruthy();
  });
});
