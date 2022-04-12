const admin = require("../../../firebase_admin_helper");

const getVendorDataByTag = async (vendorTag) => {
  const snapshot = await admin
    .firestore()
    .collection("vendors")
    .where("vendorTag", "==", vendorTag)
    .limit(1)
    .get();

  if (snapshot.empty) {
    throw { code: 400, msg: "No Vendor Was Found With The Tag " + vendorTag };
  }

  return snapshot.docs[0].data();
};

module.exports = getVendorDataByTag;
