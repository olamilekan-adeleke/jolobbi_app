const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");

const addTransferHistoryUser = async (
  userId,
  amount,
  description,
  vendorTag
) => {
  await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("transactions")
    .add({
      description: description,
      type: "send_fund",
      amount: amount,
      timestamp: admin.firestore.Timestamp.now(),
      vendorTag: vendorTag,
    });

  functions.logger.log(`added transfer history for user ${userId}`);
};

module.exports = addTransferHistoryUser;
