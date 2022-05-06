const bcrypt = require("bcrypt");
const functions = require("firebase-functions");
const getUserPinById = require("../../controllers/get_user_pin_by_id");

const verifyWalletPinFunction = async (req, res) => {
  try {
    const { pin, userId } = req.body;

    if (!pin) throw { code: 400, msg: "Pin Is Required!" };
    if (!userId) throw { code: 400, msg: "User Id Is Required!" };

    const userPinData = await getUserPinById(userId);

    const result = bcrypt.compareSync(pin, userPinData.pin);

    if (result == false) {
      throw { code: 400, msg: "Incorrect Wallet Pin!" };
    }

    res
      .status(200)
      .json({ status: "success", msg: "Wallet Pin Validation Successful!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code || 500)
      .json({ status: "fail", msg: error.msg || "something went wrong" });
  }
};

module.exports = verifyWalletPinFunction;
