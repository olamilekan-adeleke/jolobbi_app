const functions = require("firebase-functions");
const sendNotificationToUserById = require("../../controllers/notification/send_notifcation_user_by_id");

const addNewUserTransactionHistory = require("../../controllers/payment/add_new_user_transaction_history");
const updateTotalWalletAmountStat = require("../../controllers/stats/update_total_amount_stats");
const updateUserCashWallet = require("../../controllers/update_user_cash_wallet");

const processTransactionFunction = async (snapshot, context) => {
  try {
    const transactionData = snapshot.data().transactionData;
    const userId = transactionData.eventData.metaData.id;
    const amountPaid = transactionData.eventData.amountPaid;

    if (transactionData.eventData.paymentStatus === "PAID") {
      // add transaction to user transaction history!
      await addNewUserTransactionHistory({
        userId: userId,
        description: "You fund your wallet via monnify",
        metaData: transactionData,
        type: "fund_wallet",
      });

      // fund user wallet
      await updateUserCashWallet({
        userId: userId,
        amount: amountPaid,
      });

      // update stats
      await updateTotalWalletAmountStat(amountPaid);

      // send notification to user notification
      const notificationData = { type: "fund_wallet" };

      await sendNotificationToUserById(
        userId,
        "Payment Successful🤑!",
        `Your wallet has been successfully credited with NGN ${amountPaid}`,
        notificationData
      );
    } else {
      // add transaction to user transaction history!
      await addNewUserTransactionHistory({
        userId: userId,
        description: "Payment failed",
        metaData: transactionData,
        type: "fund_wallet",
      });

      // send notification to user notification
      const notificationData = { type: "fund_wallet" };

      await sendNotificationToUserById(
        userId,
        "Payment Failed💢❌!",
        `Your payment of NGN ${amountPaid} was unsuccessfully!`,
        notificationData
      );
    }

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);

    return Promise.reject(error);
  }
};

module.exports = processTransactionFunction;
