const bcrypt = require("bcryptjs");

const comparePin = (oldPin, currentHashedPin) => {
  const oldPinHashed = bcrypt.hashSync(oldPin, 10);

  const result = bcrypt.compareSync(oldPinHashed, currentHashedPin);

  if (result == false) {
    throw { code: 400, msg: "Old Pin Does Not Match!" };
  }
};

module.exports = comparePin;
