// const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

var express = require("express");
const app = express();
var S3 = require("aws-sdk/clients/s3");
const fs = require("fs");
const multer = require("multer");
const { ref } = require("firebase-functions/v1/database");

require("dotenv").config();

const bucketName = process.env.AWS_BUCKET_NAME;
const region = process.env.AWS_BUCKET_REGION;
const accessKeyId = process.env.user_access_key;
const secretAccessKey = process.env.user_secret_key;

const s3 = new S3({
  accessKeyId: accessKeyId,
  secretAccessKey: secretAccessKey,
  region: region,
});

const storage = multer.memoryStorage({
  destination: function (req, file, callback) {
    callback(null, "");
  },
});

const upload = multer({ storage }).single("image");

app.post("/upload-image", upload, async (req, res) => {
  let fileName = req.file.originalname.split(".");
  const fileType = fileName[fileName.length - 1];

  console.log(req.file);

  const params = {
    key: `234567890.${fileType}`.toString(), //`${fileName}-${new Date().valueOf()}.${fileType}`,
    Bucket: bucketName,
    Body: req.file.buffer,
    Key: "test.jpeg",
  };

  console.log(params);

  s3.upload(params, (err, data) => {
    console.log(err);

    if (err) {
      return res.status(500).json({ error: "failed", msg: err });
    }

    console.log(data.Location);

    res.send({ message: "done", data: data });
  });
});

app.listen(2022, () => {
  console.log("running on port 2022");
});
