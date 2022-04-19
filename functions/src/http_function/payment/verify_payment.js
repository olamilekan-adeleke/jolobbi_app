const functions = require("firebase-functions");
const getUserDataById = require("../../controllers/get_user_data_by_id");
const addNewUserTransactionHistory = require("../../controllers/payment/add_new_user_transaction_history");
const checkIfTransactionExist = require("../../controllers/payment/check_if_transaction_exist");
const verifyTransactionWithThirdParty = require("../../controllers/payment/verify_transaction_with_third_party");
const updateTotalWalletAmountStat = require("../../controllers/stats/update_total_amount_stats");
const updateUserCashWallet = require("../../controllers/update_user_cash_wallet");

const verifyPaymentFunction = async (req, res) => {
  try {
    const { transId, userId } = req.body;

    if (!transId || !userId) {
      throw { code: 400, msg: "Bad Request Body!" };
    }

    // get user data
    const userData = await getUserDataById(userId);

    // verify transaction with Flutterwave
    const responseData = await verifyTransactionWithThirdParty(transId);

    if (responseData.paymentStatus === "PAID") {
      // check if transaction ref already exist
      await checkIfTransactionExist(userData, responseData);

      // add transaction to user transaction history!
      await addNewUserTransactionHistory(
        userId,
        "You fund your wallet via flutterwave",
        responseData,
        "fund_wallet"
      );

      // fund user wallet
      await updateUserCashWallet(userId, responseData.amountPaid);

      // add stats
      await updateTotalWalletAmountStat(responseData.amountPaid);

      res
        .status(200)
        .json({ status: "success", msg: "Transaction Successful!" });
    } else if (responseData.paymentStatus === "PENDING") {
    } else if (responseData.paymentStatus === "EXPIRED") {
    } else if (responseData.paymentStatus === "FAILED") {
    }
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = verifyPaymentFunction;
