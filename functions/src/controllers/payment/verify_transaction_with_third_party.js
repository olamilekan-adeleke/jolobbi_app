const { fetchGetRequest } = require("../utils/http_helper");

const verifyTransactionWithThirdParty = async (id) => {
  const result = await fetchGetRequest("/api/v2/transactions/" + id);

  return response.responseBody;
};

module.exports = verifyTransactionWithThirdParty;
