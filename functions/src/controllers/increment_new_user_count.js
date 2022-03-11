const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

const incrementNewUserCount = async () => {
  const today = new Date();
  const month = today.getMonth() + 1;
  const date = today.getFullYear() + "-" + month + "-" + today.getDate();

  await admin
    .firestore()
    .collection("stats")
    .doc("new_user_count")
    .set(
      {
        [`${date}`]: admin.firestore.FieldValue.increment(1),
        [`month_${month}`]: admin.firestore.FieldValue.increment(1),
      },
      { merge: true }
    );

  functions.logger.log(`New user count incremented`);
};

module.exports = incrementNewUserCount;
