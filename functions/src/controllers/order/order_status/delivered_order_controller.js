const sendNotificationToUserById = require("../../notification/send_notification_user_by_id");

const deliveredOrderController = async (orderData) => {
  const notificationData = { type: "order" };

  await sendNotificationToUserById(
    orderData.userId,
    "Order Delivered!",
    "Your order has been delivered by a vendor and a refund has been made",
    notificationData
  );

  // TODO: send notification to user to approve order has been received
};

module.exports = deliveredOrderController;
