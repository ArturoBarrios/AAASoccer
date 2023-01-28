const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testKey) 

const calculateOrderAmount = (items) => {
    prices = [];
    catalog = [
        { 'id': '0', 'price': 2.99 },
        { 'id': '1', 'price': 3.99 },
        { 'id': '2', 'price': 4.99 },
        { 'id': '3', 'price': 5.99 },
        { 'id': '4', 'price': 6.99 },
    ];

    items.forEach(item => {
        price = catalog.find(x => x.id == item.id).price;
        prices.push(price);
    });

    return parseInt(prices.reduce((a, b) => a + b, 0) * 100);
}

const generateResponse = function (intent) {
    switch (intent.status) {
        case 'requires_action':
            return {
                clientSecret: intent.clientSecret,
                requiresAction: true,
                status: intent.status
            };
        case 'requires_payment_method':
            console.log("Payment Failed");
            return {
                'error': 'Your card was denied, please provide a new payment method'
            };
        case 'succeeded':
            console.log("Payment Succeeded");
            return {clientSecret: intent.clientSecret, status: intent.status}
    }
    return error;
}

//payment intent
exports.StripePayEndpointMethodId = functions.https.onRequest(async(req, res) => {
    const { paymentMethodId, items, currency, useStripeSdk, } =  req.body;    
    const orderAmount = calculateOrderAmount(items);    
    

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
        return res.sendStatus(400 );

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


// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
