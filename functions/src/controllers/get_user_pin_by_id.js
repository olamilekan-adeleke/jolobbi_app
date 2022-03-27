const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

const getUserPinById = async (userId) => {
  const documentSnapshot = await admin
    .firestore()
    .collection("walletPins")
    .doc(userId)
    .get();

  if (documentSnapshot.exists == false) {
    throw { code: 400, msg: "No Pin Was Found For This User!" };
  }

  return documentSnapshot.data();
};

module.exports = getUserPinById;
