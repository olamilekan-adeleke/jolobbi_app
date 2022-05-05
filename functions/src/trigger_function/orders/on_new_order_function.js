const getVendorDataByName = require("../../controllers/payment/get_business_data_by_tag");
const moveFundFromUserToJolobbiWallet = require("../../controllers/payment/move_funds_from_user_to_jolobbi_wallet");

const onNewOrderFunction = async (snapshot, context) => {
  const orderData = snapshot.data();
  const notificationData = { type: "order" };

  // move money from user wallet to jolobbi wallet
  await moveFundFromUserToJolobbiWallet({
    userId: orderData.userId,
    amount: orderData.totalFee,
  });

  // all vendor notification for new order
  orderData.vendorNameList.forEach(element => {
    //TODO: remove override later

    element = 'Shop 123';
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
    userId,
    "Order Successful!",
    "Your order has been successfully passed, you will get" +
    " a notification once all vendor has approved your order for processing",
    notificationData
  );
};

module.exports = onNewOrderFunction;
