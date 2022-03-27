const comparePin = require("../controllers/compare_pin");

const updateUserWalletPinFunction = async (req, res) => {
  try {
    const { oldPin, newPin, userId } = req.body;

    if (pin.length < 4 || !userId) {
      throw { code: 400, msg: "Bad Request Body!" };
    }

    const userPinData = await getUserPinById();

    await comparePin(oldPin, userPinData.pin);

    res.status(201).json({ status: "success", msg: "Pin Successful Updated!" });
  } catch (error) {
    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = updateUserWalletPinFunction;
