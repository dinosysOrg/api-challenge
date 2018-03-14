const path = require("path");
const qs = require("querystring");
const { isArray } = require("lodash");
const supertest = require("supertest");

const app = require("../src");

describe("Query matches", () => {
  it("should return matches by match code", async () => {
    const filterCode = "A1-1";
    const { body } = await supertest(app)
      .get(`/matches?${qs.stringify({ code: filterCode })}`)
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200);

    expect(isArray(body.data)).toBeTruthy();
    expect(typeof body.total === "number").toBeTruthy();

    let failed = [];
    for (let i = 0; i < body.data.length; i++) {
      const { code } = body.data[i];
      if (code.indexOf(filterCode) < 0) failed.push(code);
    }

    expect(failed.length).toBeFalsy();
  });

  it("should return matches by player 1 name", async () => {
    const player2Name = "Elizabeth";
    const { body } = await supertest(app)
      .get(`/matches?${qs.stringify({ player2Name })}`)
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200);

    expect(isArray(body.data)).toBeTruthy();
    expect(typeof body.total === "number").toBeTruthy();

    let failed = [];
    for (let i = 0; i < body.data.length; i++) {
      const { Player2 } = body.data[i];
      if (Player2.name.indexOf(player2Name) < 0) failed.push(Player2.name);
    }

    expect(failed.length).toBeFalsy();
  });

  it("should return matches by player 2 name", async () => {
    const player1Name = "Elizabeth";
    const { body } = await supertest(app)
      .get(`/matches?${qs.stringify({ player1Name })}`)
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200);

    expect(isArray(body.data)).toBeTruthy();
    expect(typeof body.total === "number").toBeTruthy();

    let failed = [];
    for (let i = 0; i < body.data.length; i++) {
      const { Player1 } = body.data[i];
      if (Player1.name.indexOf(player1Name) < 0) failed.push(Player1.name);
    }

    expect(failed.length).toBeFalsy();
  });
});
