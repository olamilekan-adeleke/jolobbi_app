const moveFundFromUserToJolobbiWallet = require("../../controllers/payment/move_funds_from_user_to_jolobbi_wallet");

const onNewOrderFunction = async (snapshot, context) => {
  const orderData = snapshot.data();

  // move money from user wallet to jolobbi wallet
  await moveFundFromUserToJolobbiWallet({
    userId: orderData.userId,
    amount: orderData.totalFee,
  });

  // all vendor notification for new order
  // send user notification
};

module.exports = onNewOrderFunction;
