const admin = require("../../../../firebase_admin_helper");
const functions = require("firebase-functions");

const updateVendorOrderAmount = async ({ vendorId, amount }) => {
  const today = new Date();
  const day = today.getDate();
  const month = today.getMonth() + 1;
  const date = today.getFullYear() + "-" + month + "-" + today.getDate();

  const vendorStatsRef = admin
    .firestore()
    .collection("vendors")
    .doc(vendorId)
    .collection("stats");

  await vendorStatsRef.doc("order_stats").set(
    {
      [`orderCount_day_${day}`]: admin.firestore.FieldValue.increment(1),
      [`orderCount_month_${month}`]: admin.firestore.FieldValue.increment(1),
      [`amount_day_${day}`]: admin.firestore.FieldValue.increment(
        parseFloat(amount)
      ),
      [`amount_month_${month}`]: admin.firestore.FieldValue.increment(
        parseFloat(amount)
      ),
    },
    { merge: true }
  );
};

module.exports = { updateVendorOrderAmount };
