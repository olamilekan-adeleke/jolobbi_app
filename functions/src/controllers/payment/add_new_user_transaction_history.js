const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");

const addNewUserTransactionHistory = async ({
  userId,
  description,
  metaData,
  type,
} = {}) => {
  await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("transactions")
    .add({
      description: description,
      amount: metaData.eventData.amountPaid,
      metaData: metaData,
      type: type,
      timestamp: admin.firestore.Timestamp.now(),
    });

  functions.logger.log(`add transaction history for user ${userId}`);
};

module.exports = addNewUserTransactionHistory;
