const admin = require("../../../firebase_admin_helper");
const functions = require("firebase-functions");
const updateUserCashWallet = require("../update_user_cash_wallet");

const transferFundFromJolobbiToVendor = async ({ vendorId, amount }) => {
  const jolobbiWalletRef = admin
    .firestore()
    .collection("stats")
    .doc("jolobbi_wallet_amount");

  const vendorAmount = await _getVendorFeeByPercentage(amount);

  await admin.firestore().runTransaction(async (transaction) => {
    const jolobbiWalletSnapshot = await transaction.get(jolobbiWalletRef);

    if (!jolobbiWalletSnapshot.data()) {
      throw { code: 400, msg: "Data not found!" };
    }

    // @ts-ignore
    if (jolobbiWalletSnapshot.data().cash_balance < parseInt(vendorAmount)) {
      throw { code: 400, msg: "Insufficient Balance!" };
    }

    await updateUserCashWallet({ userId: vendorId, amount: vendorAmount });

    await transaction.update(jolobbiWalletRef, {
      cash_balance: admin.firestore.FieldValue.increment(
        -parseInt(`${vendorAmount}`)
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

  const percentage = vendorPercentageSnapshot.data().percentage;

  const _amount = ((percentage / 100) * amount).toFixed(2);

  return _amount;
};

module.exports = transferFundFromJolobbiToVendor;
