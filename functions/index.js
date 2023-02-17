const functions = require("firebase-functions");
const stripe = require('stripe')("sk_test_51M6l0pDUXwYENeT4BaAfVT8ewp4Ujzb4NyD8ebB0F0s14xujWNb1MESrqqrSbtKBIm6MdnE0odAHc1IBqEyS97aH00Kzayd323") //functions.config().stripe.testKey

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
            
        });

        var resp =  generateResponse(paymentIntent);


        // const intent = await stripe.setupIntents.create({
        //     customer: customerId
        // })        

        resp['ephemeralKey'] = ephemeralKey.secret;
        resp['customer'] = customerId;
        resp['success'] = true;
        resp['intent'] = paymentIntent;
        resp['clientSecret'] = paymentIntent.client_secret,


        res.status(200).send(resp);
        // res.status(200).send({
        //     paymentIntent: paymentIntent,
        //     ephemeralKey: ephemeralKey.secret,
        //     customer: customerId,
        //     success: true,
        //     setupIntent: intent,
        // })
        
    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});


// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// const functions = require("firebase-functions");
// const stripe = require('stripe')("sk_test_51M6l0pDUXwYENeT4BaAfVT8ewp4Ujzb4NyD8ebB0F0s14xujWNb1MESrqqrSbtKBIm6MdnE0odAHc1IBqEyS97aH00Kzayd323") //

// const calculateOrderAmount = (items) => {
//     prices = [];
//     catalog = [
//         { 'id': '0', 'price': 2.99 },
//         { 'id': '1', 'price': 3.99 },
//         { 'id': '2', 'price': 4.99 },
//         { 'id': '3', 'price': 5.99 },
//         { 'id': '4', 'price': 6.99 },
//     ];

//     items.forEach(item => {
//         price = catalog.find(x => x.id == item.id).price;
//         prices.push(price);
//     });

//     return parseInt(prices.reduce((a, b) => a + b, 0) * 100);
// }

// const generateResponse = function (intent) {
//     switch (intent.status) {
//         case 'requires_action':
//             return {
//                 clientSecret: intent.clientSecret,
//                 requiresAction: true,
//                 status: intent.status
//             };
//         case 'requires_payment_method':
//             console.log("Payment Failed");
//             return {
//                 'error': 'Your card was denied, please provide a new payment method'
//             };
//         case 'succeeded':
//             console.log("Payment Succeeded");
//             return {clientSecret: intent.clientSecret, status: intent.status}
//     }
//     return error;
// }

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



