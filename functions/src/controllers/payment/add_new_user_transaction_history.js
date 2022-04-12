const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");

const addNewUserTransactionHistory = async (
  userId,
  description,
  flutterwaveData,
  type
) => {
  await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("transactions")
    .add({
      description: description,
      amount: flutterwaveData.amount,
      transactionData: flutterwaveData,
      type: type,
      timestamp: admin.firestore.Timestamp.now(),
    });

  functions.logger.log(`updated wallet for user ${userId}`);
};

module.exports = addNewUserTransactionHistory;