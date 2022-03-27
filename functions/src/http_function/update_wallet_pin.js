const functions = require("firebase-functions");
const comparePinAndUpdate = require("../controllers/compare_pin");
const getUserPinById = require("../controllers/get_user_pin_by_id");

const updateUserWalletPinFunction = async (req, res) => {
  try {
    const { oldPin, newPin, userId } = req.body;

    if (oldPin.length < 4 || newPin.length < 4 || !userId) {
      throw { code: 400, msg: "Bad Request Body!" };
    }

    const userPinData = await getUserPinById(userId);

    functions.logger.log(userPinData);

    await comparePinAndUpdate(oldPin, userPinData.pin, newPin);

    res.status(201).json({ status: "success", msg: "Pin Successful Updated!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = updateUserWalletPinFunction;
