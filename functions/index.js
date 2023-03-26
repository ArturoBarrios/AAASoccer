

const functions = require("firebase-functions");
const stripe = require('stripe')("sk_test_51M6l0pDUXwYENeT4BaAfVT8ewp4Ujzb4NyD8ebB0F0s14xujWNb1MESrqqrSbtKBIm6MdnE0odAHc1IBqEyS97aH00Kzayd323") //functions.config().stripe.testKey
const express = require('express');
const app = express();
app.listen(3000, () => console.log('Server started on port 3000'));

const generateResponse = function (intent) {
    switch (intent.status) {
        case 'requires_action': 
            return {
                clientSecret: intent.clientSecret,
                requiresAction: true,
                status: intent.status
            };
            case 'requires_payment_method':
                return {
                    'error': 'Your card was denied, please provide a new payment method',
                };
            case 'succeeded':
                console.log("Payment succeeded");
                return {
                    clientSecret: intent.clientSecret, status: intent.status
                };            
    }
    return {error: 'Failed'};
}


exports.getCustomerDetails = functions.https.onRequest(async (req, res) => {
    try{
        const customer = await stripe.customers.retrieve(
            req.query.customerId
          );

        res.status(200).send({ success: true, customer: customer });

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});

exports.listPaymentMethods = functions.https.onRequest(async (req, res) => {
    try{
        const paymentMethods = await stripe.paymentMethods.list({
            customer: req.query.customerId,
            type: 'card',
          });

        res.status(200).send({ success: true, paymentMethods: paymentMethods });

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});

exports.detachPaymentMethod = functions.https.onRequest(async (req, res) => {
    try{
        const paymentMethod = await stripe.paymentMethods.detach(
            req.body.customerId
          );        

        res.status(200).send({ success: true, detachedPaymentMethod: paymentMethod });

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});

exports.updatePaymentMethod = functions.https.onRequest(async (req, res) => {
    try{
        const paymentMethod = await stripe.paymentMethods.update(
            req.body.paymentMethod,
            {card: {exp_month: req.body.exp_month, expYear: req.body.expYear}}
          );          

        res.status(200).send({ success: true, paymentMethods: paymentMethods });

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});

exports.detachPaymentMethod = functions.https.onRequest(async (req, res) => {
    try{
        const paymentMethods = await stripe.paymentMethods.list({
            customer: req.body.customerId,
            type: 'card',
          });

        res.status(200).send({ success: true, paymentMethods: paymentMethods });

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});


exports.stripeAttachPaymentMethod = functions.https.onRequest(async (req, res) => {
    try{
        const paymentMethod = await stripe.paymentMethods.attach(
            req.body.paymentMethodId,
            {customer: req.body.customerId}
        );       
    
        res.status(200).send({ success: true, paymentMethod: paymentMethod });

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});


exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });
                
        //Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        }
        else {
            const customer = await stripe.customers.create({
                email: req.body.email
            });
            customerId = customer.data.id;
        }

        //Creates a temporary secret key linked with the customer 
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        );

        //Creates a new payment intent with amount passed in from the client
        const paymentIntent = await stripe.paymentIntents.create({
            amount: parseInt(req.body.amount),
            confirm: true,
            currency: "usd",//todo: use currency
            customer: customerId,
            payment_method_types: ['card'],
            payment_method: req.body.paymentMethodId,
            use_stripe_sdk: true,   
            confirmation_method: 'manual',  
            setup_future_usage: 'off_session'       
            
        });

        var resp =  generateResponse(paymentIntent);

        

        resp['ephemeralKey'] = ephemeralKey.secret;
        resp['customer'] = customerId;
        resp['success'] = true;
        resp['intent'] = paymentIntent;
        resp['clientSecret'] = paymentIntent.client_secret,


        res.status(200).send(resp);
        
    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});




//payment intent
exports.StripePayEndpointMethodId = functions.https.onRequest(async(req, res) => {
        
    try{
        // console.log("paymentMethodId: "+paymentMethodId);
        if(paymentMethodId){
            //create a new PaymentIntent
            const paymentIntent = await stripe.paymentIntents.create({
                amount: parseInt(req.body.amount),
                confirm: true,
                currency: "usd",//todo: use currency
                customer: customerId,
                payment_method_types: ['card'],
                payment_method: req.body.paymentMethodId,
                use_stripe_sdk: true,   
                confirmation_method: 'manual',         
                
            });
            
            return res.send(generateResponse(paymentIntent));
        }
        return res.status(400).send({success: false, error: error.message });

    }catch(e){
        print("index.js erorrrrrr: "+e.toString());
        return res.send({ error: e.message })

    }
});

//return payment intent
exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body;
    try{
        if(paymentIntentId){
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);
    } catch (e) {
        return res.send({ error: e.message })
    }

});



exports.uploadImageToAWS = functions.https.onRequest(async (req, res) => {    
    try{
        
        return res.sendStatus(400);
    } catch (e) {
        return res.send({ error: e.message })
    }

});


/**
 * 
 * get an image
} 
 */
exports.getImage = functions.https.onRequest(async (req, res) => {    
    try{
        require("dotenv").config();
        const {getSignedUrl} = require('@aws-sdk/cloudfront-signer');
        var signedUrl = await getSignedUrl({
            url: "https://d3pq1muv3j21qh.cloudfront.net"+
                "/soccerimages/" + req.body.imageName,
            dateLessThan: new Date(Date.now() + 1000 *60 * 60 *24),
            privateKey: process.env.CLOUDFRONT_PRIVATE_KEY,
            keyPairId: process.env.CLOUDFRONT_KEY_PAIR_ID
        });

        return res.send({ success: true, signedUrl: signedUrl });

    } catch (e) {
        return res.send({ error: e.message })
    }

});

/**
 * 
 * get images
} 
 */
exports.getImages = functions.https.onRequest(async (req, res) => {    
    try{
        require("dotenv").config();
        const {getSignedUrl} = require('@aws-sdk/cloudfront-signer');
        var signedUrl = await getSignedUrl({
            url: "https://d3pq1muv3j21qh.cloudfront.net"+
                "/soccerimages/Screenshot 2023-03-07 at 7.52.32 PM.png",
            dateLessThan: new Date(Date.now() + 1000 *60 * 60 *24),
            privateKey: process.env.CLOUDFRONT_PRIVATE_KEY,
            keyPairId: process.env.CLOUDFRONT_KEY_PAIR_ID
        });

        return res.send({ success: true, signedUrl: signedUrl });

    } catch (e) {
        return res.send({ error: e.message })
    }

});

/**
 * 
 * upload an image
} 
 */
exports.uploadImage = functions.https.onRequest(async (req, res) => {    
    try{
        console.log("uploadImage started");
        require("dotenv").config();
        const S3 = require('aws-sdk/clients/s3');
        const fs  = require('fs');

        var filestream = fs.createReadStream(req.file);
        
        
        const s3 = new S3({
            region: process.env.AWS_BUCKET_REGION,
            accessKeyId: process.env.AWS_ACCESS_KEY_ID,
            secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
            
        });

        const uploadParams = {
            Bucket: process.env.AWS_BUCKET_NAME,
            Body: filestream,
            Key: req.file.originalname
        }
        
        var uploadParamsResp = await s3.upload(uploadParams);

        return res.send({ success: true, uploadParamsRes: uploadParamsResp });
        
    } catch (e) {
        return res.send({ error: e.message })
    }

});

const multer = require('multer');
const upload = multer({ dest: 'uploads/' });
const { uploadFile, getFileStream, getCloudfrontSignedUrl } = require('./s3');

app.post('/uploadImage',upload.single('image'), async (req, res) => {
    try{
        // const S3 = require('aws-sdk/clients/s3');
        // const fs  = require('fs');
        // require("dotenv").config();
        console.log("uploadImage startedd");
        const file = req.file;        
        console.log(file);
        
        const result = await uploadFile(file);
        console.log(result);
        res.send({ success: true, data: result });
        

        // return res.send({ success: true, uploadParamsRes: uploadParamsResp });
        
    } catch (e) {
        return res.send({ error: e.message })
    }
});

app.get('/images', async (req, res) => {

    try{     
        console.log("images/:key startedd");   
        require("dotenv").config();
        const {getSignedUrl} = require('@aws-sdk/cloudfront-signer');
        console.log("process.env.CLOUDFRONT_PRIVATE_KEY: "+process.env.CLOUDFRONT_PRIVATE_KEY);
        console.log("process.env.CLOUDFRONT_KEY_PAIR_ID: "+process.env.CLOUDFRONT_KEY_PAIR_ID);
        var signedUrl = await getSignedUrl({            
            url: "https://d3pq1muv3j21qh.cloudfront.net/"+req.query.key, //"https://d3pq1muv3j21qh.cloudfront.net/"+"674c1b503cbfd75264d32971ef4deafe",
            dateLessThan: new Date(Date.now() + 1000 *60 * 60 *24),
            privateKey: process.env.CLOUDFRONT_PRIVATE_KEY,
            keyPairId: process.env.CLOUDFRONT_KEY_PAIR_ID
        });
       
        // console.log("signedUrl: "+signedUrl);
        // const key = "92b91c1fb572518cc9393687d9b17301";
        // const readStream = await getFileStream(key);
        // console.log("readStream: "+readStream);
        // readStream.pipe(res);
        console.log("signedUrl: "+signedUrl);
        res.send({ success: true, signedUrl: signedUrl });
        // res.send({ success: true, signedUrl: readStream });


        

        // return res.send({ success: true, signedUrl: signedUrl });

    } catch (e) {
        return res.send({ error: e.message })
    }
    

});













