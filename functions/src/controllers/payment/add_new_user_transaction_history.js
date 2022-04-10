const admin = require("../../../firebase_admin_helper");

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
    .set({
      description: description,
      transactionData: flutterwaveData,
      type: type,
      timestamp: admin.firestore.Timestamp.now(),
    });

  functions.logger.log(`updated wallet for user ${userId}`);
};

module.exports = addNewUserTransactionHistory;
