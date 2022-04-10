const functions = require("firebase-functions");
const getUserDataById = require("../../controllers/get_user_data_by_id");
const verifyTransactionWithFlutterwave = require("../../controllers/payment/verify_transaction_with_flutterwave");

const verifyPaymentFunction = async (req, res) => {
  try {
    const { transId, userId } = req.body;

    if (!transId || !userId) {
      throw { code: 400, msg: "Bad Request Body!" };
    }

    // get user data
    const userData = await getUserDataById();

    // verify transaction with Flutterwave
    const responseData = await verifyTransactionWithFlutterwave();

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
