const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateUserCashWallet = require("../update_user_cash_wallet");

const transferFundToVendor = async (vendorId, userId, amount) => {
  const userWalletRef = admin.firestore().collection("wallets").doc(userId);

  const _amount = amount * 100;

  await admin.firestore().runTransaction(async (transaction) => {
    const userWalletSnapshot = await transaction.get(userWalletRef);

    if (userWalletSnapshot.data().cash_balance < parseInt(_amount)) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateUserCashWallet({ userId: vendorId, amount: amount });

    await transaction.update(userWalletRef, {
      cash_balance: admin.firestore.FieldValue.increment(-parseInt(amount)),
    });

    functions.logger.log(`updated wallet for user ${userId}`);
  });
};

module.exports = transferFundToVendor;
