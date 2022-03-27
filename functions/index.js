const functions = require("firebase-functions");
const createUserWalletPinFunction = require("./src/http_function/create_wallet_pin");
const updateUserWalletPinFunction = require("./src/http_function/update_wallet_pin");
const onNewUserCreatedFunction = require("./src/trigger_function/on_new_user_created");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.createUserWalletPin = functions.https.onRequest(
  createUserWalletPinFunction
);

exports.updateUserWalletPin = functions.https.onRequest(
  updateUserWalletPinFunction
);

exports.onNewUserCreate = functions.firestore
  .document("/users/{userID}")
  .onCreate(onNewUserCreatedFunction);
