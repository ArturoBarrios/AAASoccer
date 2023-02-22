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

exports.getCustomerDetails = functions.https.onRequest(async (req, res) => {
    try{
        const customer = await stripe.customers.retrieve(
            "cus_NGKoZHDE8OUAUC"
          );

        res.status(200).send({ success: true, customer: customer });

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



