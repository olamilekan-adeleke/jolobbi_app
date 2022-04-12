const admin = require("../../../firebase_admin_helper");
const updateUserCashWallet = require("../update_user_cash_wallet");

const transferFundToVendor = async (vendorId, userId, amount) => {
  const userWalletRef = admin.firestore().collection("wallets").doc(userId);

  await admin.firestore().runTransaction(async (transaction) => {
    const userWalletSnapshot = await transaction.get(userWalletRef);

    if (userWalletSnapshot.cash_balance < amount * 100) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateUserCashWallet(vendorId, amount);

    await transaction.update({
      cash_balance: admin.firestore.FieldValue.increment(
        parseInt(amount) * 100
      ),
    });
  });
};

module.exports = transferFundToVendor;
