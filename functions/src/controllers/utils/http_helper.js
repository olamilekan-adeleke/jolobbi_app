const axios = require("axios");

const fetchGetRequest = async (url) => {
  try {
    const result = axios.get(url);

    return result;
  } catch (error) {
    throw { code: 500, msg: error };
  }
};

module.exports = {
  fetchGetRequest,
};
