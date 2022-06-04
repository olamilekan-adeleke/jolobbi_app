const functions = require("firebase-functions");
const deliveredOrderController = require("../../controllers/order/order_status/delivered_order_controller");
const enrouteOrderController = require("../../controllers/order/order_status/enroute_order_controller");
const pendingOrderController = require("../../controllers/order/order_status/pending_order_controller");
const rejectedOrderController = require("../../controllers/order/order_status/rejected_order_controller");

const onOrderStatusChangeFunction = async (snapshot, context) => {
  try {
    const orderData = snapshot.after.data();

    if (snapshot.before.data() === snapshot.after.data()) {
      return Promise.resolve();
    }

    //check orderStatus
    if (orderData.orderStatus == "pending") {
      await pendingOrderController(snapshot, orderData);
    } else if (orderData.orderStatus == "processing") {
    } else if (orderData.orderStatus == "enroute") {
      await enrouteOrderController(orderData);
    } else if (orderData.orderStatus == "delivered") {
      await deliveredOrderController(orderData);
    } else if (orderData.orderStatus == "completed") {
      //
    } else if (orderData.orderStatus == "rejected") {
      await rejectedOrderController(orderData);
    }
  } catch (error) {
    functions.logger.error(JSON.stringify(error));

    return Promise.reject(error);
  }
};

module.exports = onOrderStatusChangeFunction;
