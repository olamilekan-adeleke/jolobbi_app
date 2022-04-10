const functions = require("firebase-functions");

const verifyPaymentFunction = async (req, res) => {
  try {
    const { tx_ref, userId } = req.body;

    if (!tx_ref || !userId) {
      throw { code: 400, msg: "Bad Request Body!" };
    }

    // get user data

    // check if transaction ref already exist

    // added transaction to generate ledger transaction

    // add transaction to user transaction history!
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = verifyPaymentFunction;
