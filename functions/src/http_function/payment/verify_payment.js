const functions = require("firebase-functions");
const getUserDataById = require("../../controllers/get_user_data_by_id");
const checkIfTransactionExist = require("../../controllers/payment/check_if_transaction_exist");
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
    await checkIfTransactionExist(userData, responseData);

    // added transaction to generate ledger transaction
    // add transaction to user transaction history!

    res.status(200).json({ status: "success", msg: "Transaction Successful!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = verifyPaymentFunction;
