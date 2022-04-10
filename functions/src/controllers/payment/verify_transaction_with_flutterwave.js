const flutterwave = require("flutterwave-node-v3");
require("dotenv").config();

const verifyTransactionWithFlutterwave = async (id) => {
  const flw = new Flutterwave(
    process.env.flutterWavePublicKey,
    process.env.flutterWaveSecretKey
  );

  const payload = { id: id };
  const response = await flw.Transaction.verify(payload);

  if (response.status !== "success") {
    throw { code: 400, msg: response.message };
  }

  return response;
};

module.exports = verifyTransactionWithFlutterwave;
