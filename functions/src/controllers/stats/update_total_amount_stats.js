const functions = require("firebase-functions");
const admin = require("../../../firebase_admin_helper");

const updateTotalWalletAmountStat = async (amount) => {
  const today = new Date();
  const month = today.getMonth() + 1;
  const date = today.getFullYear() + "-" + month + "-" + today.getDate();

  await admin
    .firestore()
    .collection("stats")
    .doc("total_wallet_amount")
    .collection(`${today.getFullYear()}`)
    .doc("stat")
    .set(
      {
        [`${date}`]: admin.firestore.FieldValue.increment(amount),
        [`month_${month}`]: admin.firestore.FieldValue.increment(amount),
      },
      { merge: true }
    );

  functions.logger.log(`transaction wallet stat updated`);
};

module.exports = updateTotalWalletAmountStat;
