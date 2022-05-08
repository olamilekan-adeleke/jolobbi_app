const pendingOrderController = require("../../controllers/order/order_status/pending_order_controller");

const onOrderStatusChangeFunction = async (snapshot, context) => {
  const orderData = snapshot.data();

  //check orderStatus 
  if (orderData.orderStatus == "pending") {
    await pendingOrderController();
  }
};

module.exports = onOrderStatusChangeFunction;
