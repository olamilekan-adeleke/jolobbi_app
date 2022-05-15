const sendNotificationToUserById = require("../../notification/send_notification_user_by_id");

const rejectedOrderController = async (orderData) => {
  const notificationData = { type: "order" };

  await sendNotificationToUserById(
    orderData.userId,
    "Order Rejected!",
    "Your order has been rejected by a vendor😞, Tap to see more details",
    notificationData
  );
};

module.exports = rejectedOrderController;
