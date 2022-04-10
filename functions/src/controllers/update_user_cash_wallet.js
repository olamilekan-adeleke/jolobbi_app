const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

const updateUserCashWallet = async (userId, amount) => {
  await admin
    .firestore()
    .collection("wallets")
    .doc(userId)
    .update({
      cash_balance: admin.firestore.FieldValue.increment(amount * 100),
    });

  functions.logger.log(`updated wallet for user ${userId}`);
};

module.exports = updateUserCashWallet;
