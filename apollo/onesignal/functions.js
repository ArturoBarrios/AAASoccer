const OneSignal = require('@onesignal/node-onesignal');
const dotenv = require('dotenv');
dotenv.config();

var app = null;

async function initialize() {

    if (app !== null) {
        // Already initialized, no need to do it again
        return;
    }

    const configuration = OneSignal.createConfiguration({
        userKey: process.env.ONESIGNALUSERKEY,
        appKey: process.env.ONESIGNALRESTAPIKEY,
    });

    const client = new OneSignal.DefaultApi(configuration);
    app = await client.getApp(process.env.ONESIGNALAPPID);
}

async function sendMassPN() {
    await initialize();
}

async function sendPN() {
    await initialize();

}

module.exports = {
    initialize,
    sendMassPN,
    sendPN
};
