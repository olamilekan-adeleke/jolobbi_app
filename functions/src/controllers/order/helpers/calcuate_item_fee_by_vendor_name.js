const calculateItemFeeByVendorName = (itemData) => {
  const itemPrice = itemData.price;

  let addOnPrice = 0;
  let extrasPrice = 0;

  itemData.addOn.forEach((element) => {
    addOnPrice += element.price;
  });

  itemData.extras.forEach((element) => {
    extrasPrice += element.price;
  });

  return itemPrice + addOnPrice + extrasPrice;
};

module.exports = calculateItemFeeByVendorName;
