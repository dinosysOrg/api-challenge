const path = require("path");
const qs = require("querystring");
const { isArray } = require("lodash");
const supertest = require("supertest");

const app = require("../src");

describe("Query matches", () => {
  it("should statistics by player name", async () => {
    const playerName = "Elizabeth Katze";
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
    expect(Number(points)).toEqual(10);
    expect(Number(won_matches)).toEqual(3);
    expect(Number(lost_matches)).toEqual(2);
    expect(Number(drawn_matches)).toEqual(1);
  });
});
