const saveWalletPin = require("../controllers/save_wallet_pin");
const functions = require("firebase-functions");

const createUserWalletPinFunction = async (req, res) => {
  try {
    const { pin, userId } = req.body;

    if (pin.length < 4 || !userId) {
      throw { code: 400, msg: "Bad Request Body!" };
    }

    await saveWalletPin(pin, userId);

    res.status(201).json({ status: "success", msg: "Pin Successful Created!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code || 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = createUserWalletPinFunction;
