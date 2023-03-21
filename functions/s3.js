require('dotenv').config()
const fs = require('fs')
const S3 = require('aws-sdk/clients/s3')
const { getSignedUrl } = require('@aws-sdk/cloudfront-signer');

const region = process.env.AWS_BUCKET_REGION
const accessKeyId = process.env.AWS_ACCESS_KEY_ID
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY
const bucketName = process.env.AWS_BUCKET_NAME

const s3 = new S3({
    region,
    accessKeyId,
    secretAccessKey
});

 function uploadFile(file){
    const fileStream = fs.createReadStream(file.path)

    const uploadParams = {
        Bucket: bucketName,
        Body: fileStream,
        Key: file.filename
    }

    return s3.upload(uploadParams).promise()
}
exports.uploadFile = uploadFile

async function getFileStream(fileKey){
    console.log("getFileStream: " + fileKey);
    const downloadParams = {
        Key: fileKey,
        Bucket: bucketName
    }

    var readStream = await s3.getObject(downloadParams).createReadStream()
    console.log("readStream: " + readStream);

    return readStream;
}
exports.getFileStream = getFileStream

 function getCloudfrontSignedUrl(url){
    console.log("getCloudfrontSignedUrl: " + url);
    return getSignedUrl({
        url: url,
        dateLessThan: new Date(Date.now() + 1000 *60 * 60 *24),
        keyPairId: process.env.AWS_CLOUDFRONT_KEY_PAIR_ID,
        privateKeyString: process.env.AWS_CLOUDFRONT_PRIVATE_KEY
    }).promise();

    // console.log("Signed URL: " + signedUrl);
    
    // return signedUrl;

}
exports.getCloudfrontSignedUrl = getCloudfrontSignedUrl