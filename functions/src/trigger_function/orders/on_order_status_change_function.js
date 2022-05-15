const enrouteOrderController = require("../../controllers/order/order_status/enroute_order_controller");
const pendingOrderController = require("../../controllers/order/order_status/pending_order_controller");
const rejectedOrderController = require("../../controllers/order/order_status/rejected_order_controller");

const onOrderStatusChangeFunction = async (snapshot, context) => {
  const orderData = snapshot.after.data();

  if (snapshot.before.data() === snapshot.after.data()) {
    return Promise.resolve();
  }

  //check orderStatus
  if (orderData.orderStatus == "pending") {
    await pendingOrderController(orderData);
  } else if (orderData.orderStatus == "processing") {
  } else if (orderData.orderStatus == "enroute") {
    await enrouteOrderController(orderData);
  } else if (orderData.orderStatus == "completed") {
    await rejectedOrderController(orderData);
  } else if (orderData.orderStatus == "rejected") {

  }
};

module.exports = onOrderStatusChangeFunction;
