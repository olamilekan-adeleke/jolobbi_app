const admin = require("../../../firebase_admin_helper");

const checkIfTransactionExist = async (transactionData) => {
  const ledgerRef = admin
    .firestore()
    .collection("general_ledgers")
    .doc("payments")
    .collection("payments_ledgers")
    .doc(transactionData.eventData.paymentReference);

  await admin.firestore().runTransaction(async (transaction) => {
    const ledgerSnapshot = await transaction.get(ledgerRef);

    if (ledgerSnapshot.exists) {
      throw {
        code: 200,
        msg: "Duplicate Transaction, Transaction Already Exist!",
      };
    }

    await transaction.set(ledgerRef, {
      id: transactionData.eventData.paymentReference,
      user_id: transactionData.eventData.metaData.userId,
      amount: transactionData.eventData.amountPaid,
      userData: transactionData.eventData.metaData,
      transactionData: transactionData,
      timestamp: admin.firestore.Timestamp.now(),
    });
  });
};

module.exports = checkIfTransactionExist;
