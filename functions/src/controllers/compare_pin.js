const bcrypt = require("bcrypt");
const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

const comparePinAndUpdate = async (
  oldPin,
  currentHashedPin,
  newPin,
  userId
) => {
  const result = bcrypt.compareSync(oldPin, currentHashedPin);

  if (result == false) {
    throw { code: 400, msg: "Old Pin Does Not Match!" };
  }

  const pinHash = bcrypt.hashSync(newPin, 10);

  await admin.firestore().collection("walletPins").doc(userId).update({
    pin: pinHash,
    updatedAt: admin.firestore.Timestamp.now(),
  });
};

module.exports = comparePinAndUpdate;
