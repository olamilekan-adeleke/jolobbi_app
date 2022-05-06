const functions = require("firebase-functions");
const sha512 = require("js-sha512").sha512;

const computeHashForMonnify = async ({ hashSent, requestBody } = {}) => {
  const MONNIFY_SECERT_KEY = process.env.MONNIFY_SECERT_KEY;

  const hashedResult = sha512.hmac(
    MONNIFY_SECERT_KEY,
    JSON.stringify(requestBody)
  );

  if (hashedResult !== hashSent) {
    throw { code: 200, message: "Not Matched!" };
  }
};

module.exports = computeHashForMonnify;
