const bcrypt = require("bcrypt");

const comparePinAndUpdate = async (oldPin, currentHashedPin, newPin) => {
  const oldPinHashed = bcrypt.hashSync(oldPin, 10);

  const result = bcrypt.compareSync(oldPinHashed, currentHashedPin);

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
