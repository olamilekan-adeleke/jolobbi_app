// /* eslint-disable valid-jsdoc */

// const { faker } = require("@faker-js/faker");
// const admin = require("firebase-admin");
// const uuid = require("uuid");
// const GeoFirestore = require("geofirestore").GeoFirestore;

// var serviceAccount = require("../jolobbi-staging-firebase-adminsdk-c5tjv-e0d041a5df.json");

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });

// const firestoreDatabase = admin.firestore();

// const geofirestore = new GeoFirestore(firestoreDatabase);

// const geoRestaurantsCollection = geofirestore.collection("restaurants");
// const geoFoodItemsCollection = geofirestore.collection("fast_food_items");
// const geoDrinksItemsCollection = geofirestore.collection("drink_items");
// const geoSnacksItemsCollection = geofirestore.collection("snack_items");

// function log(message) {
//   console.log(`FakeDataPopulator | ${message}`);
// }

// async function generateFakeData() {
//   log("generate fake data");

//   await generateMerchant();

//   log("generate fake data");
// }

// async function createMerchantDocument(merchant) {
//   //   const documentReference = await geoRestaurantsCollection
//   //     .doc(merchant.id)
//   //     .set({ ...merchant });

//   let geoPoint = {
//     coordinates: new admin.firestore.GeoPoint(8.4806506, 4.6267146),
//   };

//   const documentReference = await geoRestaurantsCollection.add({
//     ...merchant,
//     ...geoPoint,
//   });
//   return documentReference.id;
// }

// async function generateMerchant() {
//   log("generating multiple merchants...");

//   for (let index = 0; index < 10; index++) {
//     const merchantName = faker.commerce.productName();
//     const merchantId = uuid.v4();

//     let searchKey = [];
//     let currentSearchKey = "";

//     merchantName.split("").forEach((element) => {
//       currentSearchKey += element.toLowerCase();
//       searchKey.push(currentSearchKey);
//     });

//     const merchant = {
//       id: merchantId,
//       name: merchantName,
//       image: faker.image.imageUrl(640, 640, "fast food", true),
//       categories: [faker.commerce.department(), faker.commerce.department()],
//       rating: faker.datatype.float({ max: 5 }),
//       number_of_ratings: faker.datatype.number({ max: 500 }),
//       contact: {
//         number: "08011223344",
//         email: "fast@food.com",
//       },
//       location: {
//         location_name: "Tanke, Ilorin",
//         location_des: "One place like that",
//         lat: 8.4806506,
//         lng: 4.6267146,
//       },
//       search_key: searchKey,
//     };

//     log(`generating ${index} merchants...`);

//     await createMerchantDocument(merchant);
//     await generateMerchantProduct(merchantId, merchantName);
//   }
// }

// async function generateMerchantProduct(merchantId, merchantName) {
//   log(`generating multiple product for ${merchantId}...`);

//   for (let index = 0; index < 10; index++) {
//     const productName = faker.commerce.productName();
//     const productId = uuid.v4();

//     let searchKey = [];
//     let currentSearchKey = "";

//     productName.split("").forEach((element) => {
//       currentSearchKey += element.toLowerCase();
//       searchKey.push(currentSearchKey);
//     });

//     const product = {
//       name: productName,
//       id: productId,
//       search_key: searchKey,
//       description: faker.lorem.paragraph(3),
//       image: faker.image.imageUrl(640, 640, "food", true),
//       type: "food",
//       price: faker.datatype.number({ max: 5000 }),
//       fast_food_name: merchantName,
//       fast_food_id: merchantId,
//       likes_count: 1,
//       extra: generateExtra(6),
//       addOn: generateAddOn(4),
//       average_rating: faker.datatype.number({ max: 5, precision: 0.01 }),
//       rating_count: faker.datatype.number({ max: 50000 }),
//       time_added: new Date().getTime(),
//     };

//     log(`generating ${index} product | Food ...`);

//     await createMerchantFoodProduct(product);

//     await createFoodItemReview(productId);
//   }

//   for (let index = 0; index < 5; index++) {
//     const productName = faker.commerce.productName();
//     const productId = uuid.v4();

//     let searchKey = [];
//     let currentSearchKey = "";

//     productName.split("").forEach((element) => {
//       currentSearchKey += element.toLowerCase();
//       searchKey.push(currentSearchKey);
//     });

//     const product = {
//       name: productName,
//       id: productId,
//       search_key: searchKey,
//       description: faker.lorem.paragraph(3),
//       image: faker.image.imageUrl(640, 640, "drinks", true),
//       type: "drinks",
//       price: faker.datatype.number({ max: 5000 }),
//       fast_food_name: merchantName,
//       fast_food_id: merchantId,
//       likes_count: 1,
//       average_rating: faker.datatype.number({ max: 5, precision: 0.01 }),
//       rating_count: faker.datatype.number({ max: 50000 }),
//       time_added: new Date().getTime(),
//     };

//     log(`generating ${index} product | Drinks ...`);

//     await createMerchantDrinkProduct(product);

//     await createDrinkItemReview(productId);
//   }

//   for (let index = 0; index < 5; index++) {
//     const productName = faker.commerce.productName();
//     const productId = uuid.v4();

//     let searchKey = [];
//     let currentSearchKey = "";

//     productName.split("").forEach((element) => {
//       currentSearchKey += element.toLowerCase();
//       searchKey.push(currentSearchKey);
//     });

//     const product = {
//       name: productName,
//       id: productId,
//       search_key: searchKey,
//       description: faker.lorem.paragraph(3),
//       image: faker.image.imageUrl(640, 640, "snacks", true),
//       type: "snacks",
//       price: faker.datatype.number({ max: 5000 }),
//       fast_food_name: merchantName,
//       fast_food_id: merchantId,
//       likes_count: 1,
//       average_rating: faker.datatype.number({ max: 5, precision: 0.01 }),
//       rating_count: faker.datatype.number({ max: 50000 }),
//       time_added: new Date().getTime(),
//     };

//     log(`generating ${index} product | Snacks ...`);

//     await createMerchantSnackProduct(product);

//     await createSnackItemReview(productId);
//   }
// }

// function generateExtra(count) {
//   var extra = [];

//   for (let index = 0; index < count; index++) {
//     const extraItem = {
//       name: faker.commerce.productName(),
//       image: faker.image.imageUrl(300, 300, "food", true),
//       price: faker.datatype.number({ max: 500 }),
//     };
//     extra.push(extraItem);
//   }

//   return extra;
// }

// function generateAddOn(count) {
//   var addOn = [];

//   for (let index = 0; index < count; index++) {
//     const addOnItem = {
//       name: faker.commerce.productName(),
//       image: faker.image.imageUrl(300, 300, "food", true),
//       price: faker.datatype.number({ max: 500 }),
//     };
//     addOn.push(addOnItem);
//   }

//   return addOn;
// }

// async function createMerchantFoodProduct(product) {
//   let geoPoint = {
//     coordinates: new admin.firestore.GeoPoint(8.4806506, 4.6267146),
//   };

//   await geoFoodItemsCollection.doc(product.id).set({ ...product, ...geoPoint });
// }

// async function createMerchantDrinkProduct(product) {
//   let geoPoint = {
//     coordinates: new admin.firestore.GeoPoint(8.4806506, 4.6267146),
//   };

//   await geoDrinksItemsCollection
//     .doc(product.id)
//     .set({ ...product, ...geoPoint });
// }

// async function createMerchantSnackProduct(product) {
//   let geoPoint = {
//     coordinates: new admin.firestore.GeoPoint(8.4806506, 4.6267146),
//   };

//   await geoSnacksItemsCollection
//     .doc(product.id)
//     .set({ ...product, ...geoPoint });
// }

// async function createFoodItemReview(productId) {
//   for (let index = 0; index < 10; index++) {
//     const reviewData = {
//       user_name: faker.name.findName(),
//       user_image: faker.image.imageUrl(640, 640, "food", true),
//       user_image: faker.image.imageUrl(200, 200, "person", true),
//       user_id: "123456789",
//       date_time: new Date().getTime(),
//       review: faker.lorem.paragraph(2),
//     };

//     await firestoreDatabase
//       .collection("fast_food_items")
//       .doc(productId)
//       .collection("reviews")
//       .add(reviewData);
//   }
// }

// async function createDrinkItemReview(productId) {
//   for (let index = 0; index < 10; index++) {
//     const reviewData = {
//       user_name: faker.name.findName(),
//       user_image: faker.image.imageUrl(640, 640, "food", true),
//       user_image: faker.image.imageUrl(200, 200, "person", true),
//       user_id: "123456789",
//       date_time: new Date().getTime(),
//       review: faker.lorem.paragraph(2),
//     };

//     await firestoreDatabase
//       .collection("drink_items")
//       .doc(productId)
//       .collection("reviews")
//       .add(reviewData);
//   }
// }

// async function createSnackItemReview(productId) {
//   for (let index = 0; index < 10; index++) {
//     const reviewData = {
//       user_name: faker.name.findName(),
//       user_image: faker.image.imageUrl(640, 640, "food", true),
//       user_image: faker.image.imageUrl(200, 200, "person", true),
//       user_id: "123456789",
//       date_time: new Date().getTime(),
//       review: faker.lorem.paragraph(2),
//     };

//     await firestoreDatabase
//       .collection("snack_items")
//       .doc(productId)
//       .collection("reviews")
//       .add(reviewData);
//   }
// }

// // generateFakeData();
