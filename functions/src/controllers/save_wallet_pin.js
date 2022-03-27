const functions = require("firebase-functions");
const admin = require("../../firebase_admin_helper");

const saveWalletPin = async (pin, userId) => {
  const pinHash = bcrypt.hashSync(pin, 10);

  await admin.firestore().collection("walletPins").doc(userId).set({
    pin: pinHash,
    createdAt: admin.firestore.Timestamp.now(),
    updatedAt: admin.firestore.Timestamp.now(),
  });

  functions.logger.log(`Created Wallet Pin User(${userId})`);
};

module.exports = saveWalletPin;
