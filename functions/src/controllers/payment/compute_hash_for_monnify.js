const functions = require("firebase-functions");
const sha512 = require("js-sha512").sha512;

const computeHashForMonnify = async ({ hashSent, requestBody } = {}) => {
  const monnifySecretKey = process.env.monnifySecretKey;

  const hashedResult = sha512.hmac(
    monnifySecretKey,
    JSON.stringify(requestBody)
  );

  if (hashedResult !== hashSent) {
    throw { code: 200, message: "Not Matched!" };
  }
};

module.exports = computeHashForMonnify;
