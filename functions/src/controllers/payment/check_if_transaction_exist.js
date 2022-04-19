const admin = require("../../../firebase_admin_helper");

const checkIfTransactionExist = async (userData, flutterwaveData) => {
  const ledgerRef = admin
    .firestore()
    .collection("general_ledgers")
    .doc(flutterwaveData.tx_ref);

  await admin.firestore().runTransaction(async (transaction) => {
    const ledgerSnapshot = await transaction.get(ledgerRef);

    if (ledgerSnapshot.exists) {
      throw {
        code: 400,
        msg: "Duplicate Transaction, Transaction Already Exist!",
      };
    }

    await transaction.set(ledgerRef, {
      id: flutterwaveData.tx_ref,
      user_id: userData.id,
      amount: flutterwaveData.amountPaid,
      userData: userData,
      flutterwaveData: flutterwaveData,
      timestamp: admin.firestore.Timestamp.now(),
    });
  });
};

module.exports = checkIfTransactionExist;
