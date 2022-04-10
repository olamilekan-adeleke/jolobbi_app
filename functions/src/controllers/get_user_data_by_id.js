const admin = require("../../firebase_admin_helper");

const getUserDataById = async (userId) => {
  const documentSnapshot = await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .get();

  if (documentSnapshot.exists == false) {
    throw { code: 400, msg: "No User Data Was Found For This User!" };
  }

  return documentSnapshot.data();
};

module.exports = getUserDataById;
