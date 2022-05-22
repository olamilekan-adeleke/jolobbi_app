const functions = require("firebase-functions");
const webHookHandlerFunction = require("./src/http_function/payment/web_hook_handler");
const createUserWalletPinFunction = require("./src/http_function/create_wallet_pin");
const transferToBusinessByTag = require("./src/http_function/payment/transafer_to_business_by_tag");
const updateUserWalletPinFunction = require("./src/http_function/update_wallet_pin");
const verifyWalletPinFunction = require("./src/http_function/wallet_pin/verify_pin");
const onNewUserCreatedFunction = require("./src/trigger_function/on_new_user_created");
const processTransactionFunction = require("./src/http_function/payment/process_payment");
const onNewOrderFunction = require("./src/trigger_function/orders/on_new_order_function");
const onOrderStatusChangeFunction = require("./src/trigger_function/orders/on_order_status_change_function");
const onNewVendorCreatedFunction = require("./src/trigger_function/on_new_user_created");

require("dotenv").config();

// http functions
exports.createUserWalletPin = functions.https.onRequest(
  createUserWalletPinFunction
);

exports.updateUserWalletPin = functions.https.onRequest(
  updateUserWalletPinFunction
);

exports.verifyWalletPin = functions.https.onRequest(verifyWalletPinFunction);

exports.monnifyWebHook = functions.https.onRequest(webHookHandlerFunction);

exports.transferToBusinessByTag = functions.https.onRequest(
  transferToBusinessByTag
);

// trigger function
exports.onNewUserCreate = functions.firestore
  .document("/users/{userID}")
  .onCreate(onNewUserCreatedFunction);

exports.onNewVendorCreate = functions.firestore
  .document("/vendors/{vendorID}")
  .onCreate(onNewVendorCreatedFunction);

exports.processPaymentMade = functions.firestore
  .document("/general_ledgers/payments/payments_ledgers/{paymentDocId}")
  .onCreate(processTransactionFunction);

exports.processNewOrder = functions.firestore
  .document("orders/{orderId}")
  .onCreate(onNewOrderFunction);

exports.processOrderStatus = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(onOrderStatusChangeFunction);
