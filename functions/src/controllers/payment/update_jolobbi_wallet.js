const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");

const updateJolobbiWallet = async (amount) => {
  const today = new Date();
  const month = today.getMonth() + 1;
  const date = today.getFullYear() + "-" + month + "-" + today.getDate();

  await admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount")
    .set(
      {
        amount: admin.firestore.FieldValue.increment(amount),
      },
      { merge: true }
    );

  await admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount")
    .collection(`${today.getFullYear()}`)
    .doc("stat")
    .set(
      {
        [`${date}`]: admin.firestore.FieldValue.increment(amount),
        [`month_${month}`]: admin.firestore.FieldValue.increment(amount),
      },
      { merge: true }
    );

  functions.logger.log(`updated jolobbi wallet`);
};

module.exports = updateJolobbiWallet;
