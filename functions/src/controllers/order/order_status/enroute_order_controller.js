const sendNotificationToUserById = require("../../notification/send_notification_user_by_id");

const enrouteOrderController = async (orderData) => {
  const notificationData = { type: "order" };

  await sendNotificationToUserById(
    orderData.userId,
    "Order Enroute!",
    "Your order has been processed by all vendor and your food is on his way",
    notificationData
  );
};

module.exports = enrouteOrderController;
