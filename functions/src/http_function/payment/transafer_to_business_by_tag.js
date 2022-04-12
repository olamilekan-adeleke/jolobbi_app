const functions = require("firebase-functions");
const sendNotificationHelper = require("../../controllers/notification/notification_helper");
const sendNotificationToUserById = require("../../controllers/notification/send_notifcation_user_by_id");
const addTransferHistoryUser = require("../../controllers/payment/add_transfer_history_for_user");
const getVendorDataByTag = require("../../controllers/payment/get_business_data_by_tag");
const transferFundToVendor = require("../../controllers/payment/transfer_fund_to_vendor");

const transferToBusinessByTag = async (req, res) => {
  try {
    const { businessTag, userId, amount } = req.body;

    if (!businessTag) throw { code: 400, msg: "Vendor Tag Is Required" };

    if (!userId) throw { code: 400, msg: "User ID Is Required" };

    if (!amount) throw { code: 400, msg: "Amount Is Required" };

    // get business data by business tag
    const vendorData = await getVendorDataByTag(businessTag);

    functions.logger.log(vendorData);

    // make transfer from user wallet to vendor wallet
    await transferFundToVendor(vendorData.id, userId, amount);

    const notificationData = { type: "fund_transfer" };

    await sendNotificationToUserById(
      userId,
      "Fund Transfer Successful!",
      `Your transfer for NGN ${amount} to @${businessTag} was successful!`,
      notificationData
    );

    await sendNotificationHelper(
      vendorData.fcm_token,
      "Fund Received!",
      `Your just received NGN ${amount} from a user!`,
      notificationData
    );

    // add to transaction history to user
    addTransferHistoryUser(userId, amount, "Transfer fund to ", businessTag);

    res.status(200).json({ status: "success", msg: "Transfer Successful!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = transferToBusinessByTag;
