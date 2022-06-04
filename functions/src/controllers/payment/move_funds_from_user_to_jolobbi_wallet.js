const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateJolobbiWallet = require("./update_jolobbi_wallet");
const sendNotificationToUserById = require("../notification/send_notification_user_by_id");

// @ts-ignore
const moveFundFromUserToJolobbiWallet = async ({ userId, amount } = {}) => {
  const userWalletRef = admin.firestore().collection("wallets").doc(userId);
  const userDataRef = admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("transactions");

  await admin.firestore().runTransaction(async (transaction) => {
    const userWalletSnapshot = await transaction.get(userWalletRef);

    if (userWalletSnapshot.data().cash_balance < parseInt(amount)) {
      await sendNotificationToUserById(
        userId,
        "Order Failed!",
        "Your order could not be processed, Insufficient Balance!",
        { type: "order" }
      );

      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateJolobbiWallet(amount);

    await transaction.update(userWalletRef, {
      cash_balance: admin.firestore.FieldValue.increment(-parseInt(amount)),
    });

    functions.logger.log("move fund from user wallet to jolobbi wallet ");
  });

  await userDataRef.add({
    description: `Debited ${amount}`,
    amount: amount,
    type: "debit",
    timestamp: admin.firestore.Timestamp.now(),
  });
};

module.exports = moveFundFromUserToJolobbiWallet;
