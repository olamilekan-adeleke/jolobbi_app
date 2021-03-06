const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateUserCashWallet = require("../update_user_cash_wallet");
const calculateVendorFeePercentage = require("../order/helpers/calculate_vendor_fee_percentage");
const { updateVendorOrderAmount } = require("./helper/update_vendor_stats");

const transferFundFromJolobbiToVendorById = async ({ receiverId, amount }) => {
  const jolobbiWalletRef = admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount");

  const vendorDataRef = admin
    .firestore()
    .collection("vendors")
    .doc(receiverId)
    .collection("transactions");

  const vendorAmount = await calculateVendorFeePercentage(amount);

  await admin
    .firestore()
    .runTransaction(async (transaction) => {
      const jolobbiWalletSnapshot = await transaction.get(jolobbiWalletRef);

      if (!jolobbiWalletSnapshot.data()) {
        throw { code: 400, msg: "Data not found!" };
      }

      // @ts-ignore
      if (jolobbiWalletSnapshot.data().amount < vendorAmount) {
        throw { code: 400, msg: "Insufficient Balance!" };
      }

      await updateUserCashWallet({ userId: receiverId, amount: vendorAmount });

      await transaction.update(jolobbiWalletRef, {
        amount: admin.firestore.FieldValue.increment(-vendorAmount),
      });

      functions.logger.log(`updated wallet for vendor ${receiverId}`);
    })
    .catch((error) => {
      functions.logger.error(JSON.stringify(error));

      return Promise.reject(error);
    });

  functions.logger.log(`added history vendor ${receiverId}`);

  await vendorDataRef.add({
    description: `You Just Received NGN ${vendorAmount}`,
    amount: parseFloat(`${vendorAmount.toString()}`),
    type: "credit",
    timestamp: admin.firestore.Timestamp.now(),
  });

  await updateVendorOrderAmount({ vendorId: receiverId, amount: vendorAmount });

  functions.logger.log(`update vendor stats ${receiverId}`);
};

const transferFundFromJolobbiToUserById = async ({ receiverId, amount }) => {
  const jolobbiWalletRef = admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount");

  const userDataRef = admin
    .firestore()
    .collection("users")
    .doc(receiverId)
    .collection("transactions");

  const refundAmount = parseInt(`${amount.toString()}`);

  await admin
    .firestore()
    .runTransaction(async (transaction) => {
      const jolobbiWalletSnapshot = await transaction.get(jolobbiWalletRef);

      if (!jolobbiWalletSnapshot.data()) {
        throw { code: 400, msg: "Data not found!" };
      }

      // @ts-ignore
      if (jolobbiWalletSnapshot.data().amount < refundAmount) {
        throw { code: 400, msg: "Insufficient Balance!" };
      }

      await updateUserCashWallet({ userId: receiverId, amount: refundAmount });

      await transaction.update(jolobbiWalletRef, {
        amount: admin.firestore.FieldValue.increment(-refundAmount),
      });

      functions.logger.log(`refund user fund ${receiverId}`);
    })
    .catch((error) => {
      functions.logger.error(JSON.stringify(error));

      return Promise.reject(error);
    });

  await userDataRef.add({
    description: `You Just Received NGN ${refundAmount}`,
    amount: refundAmount,
    type: "credit",
    timestamp: admin.firestore.Timestamp.now(),
  });
};

module.exports = {
  transferFundFromJolobbiToVendorById,
  transferFundFromJolobbiToUserById,
};
// module.exports = ;
