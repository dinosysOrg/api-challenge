const path = require("path");
const { isArray } = require("lodash");
const supertest = require("supertest");

const app = require("../src");

describe("Upload csv", () => {
  const tournament9Ball = path.resolve(
    __dirname,
    `assets/tournament_9_ball.csv`
  );
  const tournament10Ball = path.resolve(
    __dirname,
    `assets/tournament_10_ball.csv`
  );

  it("should upload csv and return saved rows", async () => {
    const { body } = await supertest(app)
      .post("/upload")
      .set("Accept", "application/json")
      .attach("files", tournament9Ball)
      .attach("files", tournament10Ball)
      .expect("Content-Type", /json/)
      .expect(200);

    expect(body.data.failed.length).toBeFalsy();
  });
});
