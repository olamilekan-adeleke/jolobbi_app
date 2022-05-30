const functions = require("firebase-functions");
const sendNotificationHelper = require("../../controllers/notification/notification_helper");
const sendNotificationToUserById = require("../../controllers/notification/send_notification_user_by_id");
const getVendorDataByName = require("../../controllers/payment/get_business_data_by_tag");
const moveFundFromUserToJolobbiWallet = require("../../controllers/payment/move_funds_from_user_to_jolobbi_wallet");

const onNewOrderFunction = async (snapshot, context) => {
  try {
    const orderData = snapshot.data();
    const notificationData = { type: "order" };

    // move money from user wallet to jolobbi wallet
    await moveFundFromUserToJolobbiWallet({
      userId: orderData.userId,
      amount: orderData.totalFee,
    });

    // all vendor notification for new order
    await orderData.vendorNameList.forEach(async (element) => {
      

      // element = "Shop 123";
      const vendorData = await getVendorDataByName(element);

      await sendNotificationHelper(
        vendorData.fcm_token,
        "New Order Alert!",
        `A new order was just made!`,
        notificationData
      );
    });

    // send user notification
    await sendNotificationToUserById(
      orderData.userId,
      "Order Successful!",
      "Your order has been successfully placed, you will get" +
        " a notification once all vendor has approved your order for processing",
      notificationData
    );
  } catch (error) {
    functions.logger.error(error);

    return Promise.reject(error);
  }
};

module.exports = onNewOrderFunction;
