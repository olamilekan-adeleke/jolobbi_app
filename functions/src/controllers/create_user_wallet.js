const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

const createUserWallet = async (userId) => {
  await admin.firestore().collection("wallets").doc(userId).set({
    cash_balance: 100,
    coin_balance: 50,
  });

  functions.logger.log(`created wallet for user ${userId}`);
};

module.exports = createUserWallet;
