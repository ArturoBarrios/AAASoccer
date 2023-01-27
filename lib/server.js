const stripe = require('stripe')('sk_test_51M6l0pDUXwYENeT4BaAfVT8ewp4Ujzb4NyD8ebB0F0s14xujWNb1MESrqqrSbtKBIm6MdnE0odAHc1IBqEyS97aH00Kzayd323');
// This example sets up an endpoint using the Express framework.
// Watch this video to get started: https://youtu.be/rPR2aJ6XnAc.

app.post('/payment-sheet', async (req, res) => {
  // Use an existing Customer ID if this is a returning customer.
  const customer = await stripe.customers.create();
  const ephemeralKey = await stripe.ephemeralKeys.create(
    {customer: customer.id},
    {apiVersion: '2022-11-15'}
  );
  const paymentIntent = await stripe.paymentIntents.create({
    amount: 1099,
    currency: 'eur',
    customer: customer.id,
    automatic_payment_methods: {
      enabled: true,
    },
  });

  res.json({
    paymentIntent: paymentIntent.client_secret,
    ephemeralKey: ephemeralKey.secret,
    customer: customer.id,
    publishableKey: 'pk_test_51M6l0pDUXwYENeT4Q3M9zZo8lhIG5kAp1H7f7AZjb5jaG9Uw75gNAYyKqSIHsmmQFa09sw4VuSWfVQSG8kkYypAj00QzhI0NcI'
  });
});