const functions = require("firebase-functions");
const createUserWalletPinFunction = require("./src/http_function/create_wallet_pin");
const verifyPaymentFunction = require("./src/http_function/payment/verify_payment");
const updateUserWalletPinFunction = require("./src/http_function/update_wallet_pin");
const onNewUserCreatedFunction = require("./src/trigger_function/on_new_user_created");
require("dotenv").config();


// http functions

exports.createUserWalletPin = functions.https.onRequest(
  createUserWalletPinFunction
);

exports.updateUserWalletPin = functions.https.onRequest(
  updateUserWalletPinFunction
);

exports.verifyPayment = functions.https.onRequest(verifyPaymentFunction);

// trigger function

exports.onNewUserCreate = functions.firestore
  .document("/users/{userID}")
  .onCreate(onNewUserCreatedFunction);
