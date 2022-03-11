const functions = require("firebase-functions");

const onNewUserCreatedFunction = async (context, snapshot) => {
  try {
    const user = snapshot.data();

    // create wallet for user
    await createUserWallet(user.id);

    // update new user count
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};
