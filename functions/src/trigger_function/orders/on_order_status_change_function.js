const pendingOrderController = require("../../controllers/order/order_status/pending_order_controller");

const onOrderStatusChangeFunction = async (snapshot, context) => {
  const orderData = snapshot.after.data();

  if (snapshot.before.data() === snapshot.after.data()) {
    return Promise.resolve();
  }

  //check orderStatus
  if (orderData.orderStatus == "pending") {
    await pendingOrderController(orderData);
  }
};

module.exports = onOrderStatusChangeFunction;
