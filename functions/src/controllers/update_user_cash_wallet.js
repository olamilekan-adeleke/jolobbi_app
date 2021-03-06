const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

// @ts-ignore
const updateUserCashWallet = async ({userId, amount}={}) => {
  await admin
    .firestore()
    .collection("wallets")
    .doc(userId)
    .update({
      cash_balance: admin.firestore.FieldValue.increment(parseInt(amount)),
    });

  functions.logger.log(`updated wallet for user ${userId}`);

  return;
};

module.exports = updateUserCashWallet;
