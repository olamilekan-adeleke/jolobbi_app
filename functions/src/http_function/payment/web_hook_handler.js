const functions = require("firebase-functions");
const computeHashForMonnify = require("../../controllers/payment/compute_hash_for_monnify");
const checkIfTransactionExist = require("../../controllers/payment/check_if_transaction_exist");

const webHookHandlerFunction = async (req, res) => {
  try {
    // get monnify signature form header
    const monnifySignature = req.get("monnify-signature");

    // compute hash to validate notification from monnify
    await computeHashForMonnify({
      hashSent: monnifySignature,
      requestBody: req.body,
    });

    // save data to backend
    await checkIfTransactionExist(req.body);

    res.status(200).json({ status: "success" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = webHookHandlerFunction;
