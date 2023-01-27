const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testKey) 

exports.StripePayEndpointMethodId = functions.https.onRequest(async(req, res) => {
    const { paymentMethodId, items, currency, useStripeSdk, } =  req.body;
    
    const orderAmount = 1000;    

    try{
        if(paymentMethodId){
            //create a new PaymentIntent
            const params = {
                amount: orderAmount, 
                confirm: true,
                confirmation_method: 'manual',
                currency: currency,
                payment_method: paymentMethodId,
                use_stripe_sdk: useStripeSdk,
            }
            const intent = await stripe.paymentIntents.create(params);
            console.log('Intent: ', intent);
            return res.send(generateResponse(intent));
        }

    }catch(e){
        print("index.js erorrrrrr: "+e.toString());

    }
});

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
