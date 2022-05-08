const sendNotificationToUserById = require("../../notification/send_notification_user_by_id");
const getVendorDataByName = require("../../payment/get_business_data_by_tag");
const transferFundFromJolobbiToVendor = require("../../payment/transfer_fund_from_jolobbi_to_vendor");

const pendingOrderController = async (orderData) => {
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

    //pay all vendor
    await orderData.vendorNameList.forEach(async (element) => {
      const vendorData = await getVendorDataByName(element);

        
        //? continuc
      await transferFundFromJolobbiToVendor({
        vendorId: vendorData.id,
        amount: 10,
      });
    });
    //
    //send notification to vendor to start processing order
    //
    //
  } else {
    return Promise.resolve();
  }
};

module.exports = pendingOrderController;
