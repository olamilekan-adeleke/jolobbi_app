const flutterwave = require("flutterwave-node-v3");

const verifyTransactionWithThirdParty = async (id) => {
  const flw = new flutterwave(
    process.env.flutterWavePublicKey,
    process.env.flutterWaveSecretKey
  );

  const payload = { id: id };
  const response = await flw.Transaction.verify(payload);

  if (response.status !== "success") {
    throw { code: 400, msg: response.message };
  }

  return response.data;
};

module.exports = verifyTransactionWithThirdParty;
