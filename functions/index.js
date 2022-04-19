const functions = require("firebase-functions");
const createUserWalletPinFunction = require("./src/http_function/create_wallet_pin");
const transferToBusinessByTag = require("./src/http_function/payment/transafer_to_business_by_tag");
const verifyPaymentFunction = require("./src/http_function/payment/verify_payment");
const updateUserWalletPinFunction = require("./src/http_function/update_wallet_pin");
const verifyWalletPinFunction = require("./src/http_function/wallet_pin/verify_pin");
const onNewUserCreatedFunction = require("./src/trigger_function/on_new_user_created");
require("dotenv").config();

// http functions

exports.createUserWalletPin = functions.https.onRequest(
  createUserWalletPinFunction
);

exports.updateUserWalletPin = functions.https.onRequest(
  updateUserWalletPinFunction
);

exports.verifyWalletPin = functions.https.onRequest(verifyWalletPinFunction);

// TODO: deprecated functions
exports.verifyPayment = functions.https.onRequest(verifyPaymentFunction);

exports.monnifyWebHook = functions.https.onRequest();

exports.transferToBusinessByTag = functions.https.onRequest(
  transferToBusinessByTag
);

// trigger function
exports.onNewUserCreate = functions.firestore
  .document("/users/{userID}")
  .onCreate(onNewUserCreatedFunction);
