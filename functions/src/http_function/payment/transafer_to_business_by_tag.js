const functions = require("firebase-functions");

const transferToBusinessByTag = async (req, res) => {
  try {
    const { businessTag, userId } = req.body;

    // get bussiness data by bussiness tag
    const vendorData = await getVendorDataByTag(businessTag);

    // make transfer from user wallet to vendor wallet

    res.status(200).json({ status: "success", msg: "Transfer Successful!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = transferToBusinessByTag;
