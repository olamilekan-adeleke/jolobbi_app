const functions = require("firebase-functions");
const getUserDataById = require("../get_user_data_by_id");
const sendNotificationHelper = require("./notification_helper");

const sendNotificationToUserById = async (userId, title, body, data) => {
  const userData = await getUserDataById(userId);

  if (!userData || !userData.fcm_token) {
    functions.logger.warn(`unable send notification for user ${userId}`);
    return;
  }

  const fcmToken = userData.fcm_token;

  functions.logger.log(`fcm token ${fcmToken}`);

  await sendNotificationHelper(fcmToken, title, body, data);

  functions.logger.log(`send notification for user ${userId}`);
};

module.exports = sendNotificationToUserById;
