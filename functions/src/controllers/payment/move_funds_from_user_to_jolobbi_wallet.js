const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateJolobbiWallet = require("./update_jolobbi_wallet");

// @ts-ignore
const moveFundFromUserToJolobbiWallet = async ({ userId, amount } = {}) => {
  const userWalletRef = admin.firestore().collection("wallets").doc(userId);

  await admin.firestore().runTransaction(async (transaction) => {
    const userWalletSnapshot = await transaction.get(userWalletRef);

    if (userWalletSnapshot.data().cash_balance < parseInt(amount)) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateJolobbiWallet(amount);

    await transaction.update(userWalletRef, {
      cash_balance: admin.firestore.FieldValue.increment(-parseInt(amount)),
    });

    functions.logger.log("move fund from user wallet to jolobbi wallet ");
  });
};

module.exports = moveFundFromUserToJolobbiWallet;
