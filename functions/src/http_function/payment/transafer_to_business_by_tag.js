const functions = require("firebase-functions");
const getVendorDataByTag = require("../../controllers/payment/get_business_data_by_tag");
const transferFundToVendor = require("../../controllers/payment/transfer_fund_to_vendor");

const transferToBusinessByTag = async (req, res) => {
  try {
    const { businessTag, userId, amount } = req.body;

    if (!businessTag) throw { code: 400, msg: "Vendor Tag Is Required" };

    if (!userId) throw { code: 400, msg: "User ID Is Required" };

    if (!amount) throw { code: 400, msg: "Amount Tag Is Required" };

    // get bussiness data by bussiness tag
    const vendorData = await getVendorDataByTag(businessTag);

    functions.logger.log(vendorData);

    // make transfer from user wallet to vendor wallet
    await transferFundToVendor(vendorData.id, userId, amount);

    res.status(200).json({ status: "success", msg: "Transfer Successful!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 500)
      .json({ status: "fail", msg: error.msg ?? "something went wrong" });
  }
};

module.exports = transferToBusinessByTag;
