const calculateItemFeeByVendorName = (itemData) => {
  const itemPrice = itemData.price * itemData.count;

  let addOnPrice = 0;
  let extrasPrice = 0;

  itemData.addOn.forEach((element) => {
    addOnPrice += element.price * element.count;
  });

  itemData.extras.forEach((element) => {
    extrasPrice += element.price * element.count;
  });

  return itemPrice + addOnPrice + extrasPrice;
};

module.exports = calculateItemFeeByVendorName;
