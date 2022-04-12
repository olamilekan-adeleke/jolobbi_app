const functions = require("firebase-functions");

const transferToBusinessByTag = async (req, res) => {
  try {
    const { businessTag, userId } = req.body;

    // get bussiness data by bussiness tag

    


  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = transferToBusinessByTag;
