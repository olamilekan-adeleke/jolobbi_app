const sendNotificationToUserById = require("../../notification/send_notification_user_by_id");
const transferFundFromJolobbiToUserById = require("../../payment/transfer_fund_from_jolobbi_to_vendor");

const rejectedOrderController = async (orderData) => {
  const notificationData = { type: "order" };

  await sendNotificationToUserById(
    orderData.userId,
    "Order Rejected!",
    "Your order has been rejected by a vendor and a refund has been made" +
      " back to your wallet😞, Tap to see more details",
    notificationData
  );

  await transferFundFromJolobbiToUserById({
    receiverId: orderData.userId,
    amount: orderData.totalFee,
  });
};

module.exports = rejectedOrderController;
