const functions = require("firebase-functions");
const incrementNewUserCount = require("../controllers/increment_new_user_count");
const createUserWallet = require("../controllers/create_user_wallet");
const incrementNewVendorCount = require("../controllers/increment_new_user_count");

const onNewUserCreatedFunction = async (snapshot, context) => {
  try {
    const user = snapshot.data();

    // create wallet for user
    await createUserWallet(user.id);

    // update new user count
    await incrementNewUserCount();

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};

const onNewVendorCreatedFunction = async (snapshot, context) => {
  try {
    const user = snapshot.data();

    // create wallet for user
    await createUserWallet(user.id);

    // update new user count
    await incrementNewVendorCount();

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};

module.exports = onNewUserCreatedFunction;
module.exports = onNewVendorCreatedFunction;
