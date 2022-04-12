const admin = require("../../../firebase_admin_helper");
const updateUserCashWallet = require("../update_user_cash_wallet");

const transferFundToVendor = async (vendorId, userId, amount) => {
  const userWalletRef = admin.firestore().collection("wallets").doc(userId);

  await admin.firestore().runTransaction(async (transaction) => {
    const userWalletSnapshot = await transaction.get(userWalletRef);

    if (userWalletSnapshot.cash_balance < amount) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateUserCashWallet(vendorId, amount);

    await updateUserCashWallet(userId, -amount);
  });
};

module.exports = transferFundToVendor;
