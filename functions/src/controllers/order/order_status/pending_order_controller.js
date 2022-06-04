const admin = require("firebase-admin");
const functions = require("firebase-functions");
const sendNotificationHelper = require("../../notification/notification_helper");
const sendNotificationToUserById = require("../../notification/send_notification_user_by_id");
const getVendorDataByName = require("../../payment/get_business_data_by_tag");
const {transferFundFromJolobbiToVendorById} = require("../../payment/transfer_fund_from_jolobbi_to_vendor");
const calculateItemFeeByVendorName = require("../helpers/calcuate_item_fee_by_vendor_name");

const pendingOrderController = async ({ snapshot, orderData }) => {
  let approvedItemCount = 0;
  const notificationData = { type: "order" };

  //check items List if all item has been approved e.g {approved: true}
  const orderItemList = orderData.items;

  for (let index = 0; index < orderItemList.length; index++) {
    const currentItem = orderItemList[index];

    if (currentItem.approved === true) {
      approvedItemCount += 1;
    }
  }

  //check if every vendor have accepted the order, if yes..
  if (approvedItemCount === orderItemList.length) {
    //send notification to user that order are being processed
    await sendNotificationToUserById(
      orderData.userId,
      "Order Processing!",
      "Your order has been approved by all vendor and is been processed",
      notificationData
    );

    // update order status
    await admin
      .firestore()
      .doc(`orders/${orderData.orderId}`)
      .update({ orderStatus: "processing" });

    //pay all vendor
    await orderData.vendorNameList.forEach(async (element) => {
      const foodItem = orderData.items.find((item) => {
        return item.fastFoodName === element;
      });

      const totalFee = calculateItemFeeByVendorName(foodItem);

      // element = "Shop 123";
      const vendorData = await getVendorDataByName(element);

      await transferFundFromJolobbiToVendorById({
        receiverId: vendorData.id,
        amount: totalFee,
      });

      //send notification to vendor to start processing order
      await sendNotificationHelper(
        vendorData.fcm_token,
        "Alert!",
        "New order to process is available, please prepare order while driver is on his way to pick it up!",
        notificationData
      );
    });
  } else {
    return Promise.resolve();
  }
};

module.exports = pendingOrderController;
