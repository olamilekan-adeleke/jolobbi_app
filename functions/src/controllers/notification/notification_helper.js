const admin = require("../../../firebase_admin_helper");

const sendNotificationHelper = async (token, title, body, data) => {
  const options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
  };

  const payload = {
    notification: {
      title: `${title}`,
      body: `${body}`,
    },
    data: data,
    token: token,
  };

  return admin.messaging().send(payload);
};

module.exports = sendNotificationHelper;
