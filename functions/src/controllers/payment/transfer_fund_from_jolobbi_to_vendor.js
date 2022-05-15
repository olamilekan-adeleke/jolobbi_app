const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateUserCashWallet = require("../update_user_cash_wallet");

const transferFundFromJolobbiToVendor = async ({ vendorId, amount }) => {
  const jolobbiWalletRef = admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount");

  const vendorAmount = await _getVendorFeeByPercentage(amount);

  functions.logger.log("vendorAmount: " + vendorAmount);

  await admin.firestore().runTransaction(async (transaction) => {
    const jolobbiWalletSnapshot = await transaction.get(jolobbiWalletRef);

    if (!jolobbiWalletSnapshot.data()) {
      throw { code: 400, msg: "Data not found!" };
    }

    if (jolobbiWalletSnapshot.data().cash_balance < parseFloat(vendorAmount)) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateUserCashWallet({ userId: vendorId, amount: vendorAmount });

    await transaction.update(jolobbiWalletRef, {
      cash_balance: admin.firestore.FieldValue.increment(
        -parseFloat(`${vendorAmount}`)
      ),
    });

    functions.logger.log(`updated wallet for vendor ${vendorId}`);
  });
};

const _getVendorFeeByPercentage = async (amount) => {
  const vendorPercentageSnapshot = await admin
    .firestore()
    .collection("fees")
    .doc("vendor_percentage")
    .get();

  if (vendorPercentageSnapshot.data() == undefined) {
    throw { code: 400, msg: "No Vendor Percentage Data Found" };
  }

  functions.logger.log(JSON.stringify(vendorPercentageSnapshot.data()));
  functions.logger.log(JSON.stringify(vendorPercentageSnapshot.data().percent));

  const percentage = vendorPercentageSnapshot.data().percent || 0;



  const _amount = ((percentage / 100) * amount).toFixed(2);


  functions.logger.log(_amount);

  return _amount;
};

module.exports = transferFundFromJolobbiToVendor;
