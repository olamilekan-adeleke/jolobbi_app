const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateUserCashWallet = require("../update_user_cash_wallet");

const transferFundFromUserToVendor = async (vendorId, userId, amount) => {
  const userWalletRef = admin.firestore().collection("wallets").doc(userId);

  await admin.firestore().runTransaction(async (transaction) => {
    const userWalletSnapshot = await transaction.get(userWalletRef);

    if (!userWalletSnapshot.data()) {
      throw { code: 400, msg: "User Data not found!" };
    }

    // @ts-ignore
    if (userWalletSnapshot.data().cash_balance < parseInt(amount)) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateUserCashWallet({ userId: vendorId, amount: amount });

    await transaction.update(userWalletRef, {
      cash_balance: admin.firestore.FieldValue.increment(-parseInt(amount)),
    });

    functions.logger.log(`updated wallet for user ${userId}`);
  });
};

module.exports = transferFundFromUserToVendor;
