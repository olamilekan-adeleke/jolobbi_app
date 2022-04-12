const admin = require("../../../firebase_admin_helper");

const sendNotification = async (token, title, body, data) => {
  const payload = {
    notification: {
      title: `${title}`,
      body: `${body}`,
    },
    data: data,
    token: token,
  };

  const options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
  };

  return admin.messaging().sendToDevice(payload, options);
};

module.exports = sendNotification;
