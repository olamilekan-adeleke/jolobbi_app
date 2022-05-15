const admin = require("../../../../firebase_admin_helper");

const calculateVendorFeePercentage = async (amount) => {
  const vendorPercentageSnapshot = await admin
    .firestore()
    .collection("fees")
    .doc("vendor_percentage")
    .get();

  if (vendorPercentageSnapshot.data() == undefined) {
    throw { code: 400, msg: "No Vendor Percentage Data Found" };
  }

  const percentage = vendorPercentageSnapshot.data().percent || 0;

  const _amount = ((percentage / 100) * amount).toFixed(2);

  return _amount;
};


module.exports = calculateVendorFeePercentage;