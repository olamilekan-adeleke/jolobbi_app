const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateUserCashWallet = require("../update_user_cash_wallet");
const calculateVendorFeePercentage = require("../order/helpers/calculate_vendor_fee_percentage");

const transferFundFromJolobbiToVendorOrUserById = async ({
  receiverId,
  amount,
}) => {
  const jolobbiWalletRef = admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount");

  const vendorAmount = await calculateVendorFeePercentage(amount);

  await admin
    .firestore()
    .runTransaction(async (transaction) => {
      const jolobbiWalletSnapshot = await transaction.get(jolobbiWalletRef);

      if (!jolobbiWalletSnapshot.data()) {
        throw { code: 400, msg: "Data not found!" };
      }

      if (jolobbiWalletSnapshot.data().amount < vendorAmount) {
        throw { code: 400, msg: "Insufficient Balance!" };
      }

      await updateUserCashWallet({ userId: receiverId, amount: vendorAmount });

      await transaction.update(jolobbiWalletRef, {
        amount: admin.firestore.FieldValue.increment(-vendorAmount),
      });

      functions.logger.log(`updated wallet for vendor/user ${receiverId}`);
    })
    .catch((error) => {
      functions.logger.error(JSON.stringify(error));

      return Promise.reject(error);
    });
};

module.exports = transferFundFromJolobbiToVendorOrUserById;
