import OneSignal from '@onesignal/node-onesignal';
import dotenv from 'dotenv';
dotenv.config();

var app = null;
var client = null;

async function initialize() {
    console.log("initialize!");

    if (app !== null) {
        console.log("app is not null");
        // Already initialized, no need to do it again
        return;
    }

    const configuration = OneSignal.createConfiguration({
        userKey: process.env.ONESIGNALUSERKEY,
        appKey: process.env.ONESIGNALRESTAPIKEY,
    });

    client = new OneSignal.DefaultApi(configuration);
    app = await client.getApp(process.env.ONESIGNALAPPID);
}

async function sendMassPN() {
    await initialize();
    const notification = new OneSignal.Notification();
    notification.app_id = app.id;

    notification.contents = {
        en: "Gig'em Ags"
    }

    // required for Huawei
    notification.headings = {
        en: "Gig'em Ags"
    }

    // This example uses filters, but you can also use segments or target individual users
    // https://documentation.onesignal.com/reference/create-notification#send-to-users-based-on-filters
    notification.filters = [
        {
            field: 'last_session',
            relation: '>',
            value: "1"
        },
    ];

    const notificationResponse = await client.createNotification(notification);
}

async function sendPNToPlayers(waitListedUsers) {
    console.log("sendPNToPlayers: "+ waitListedUsers);
    await initialize();
    console.log("initialized");
    const notification = new OneSignal.Notification();
    notification.app_id = app.id;

    notification.contents = {
        en: "Gig'em Ags"
    }

    // required for Huawei
    notification.headings = {
        en: "Gig'em Ags"
    }

    // Extract OSPID values using bracket notation and use them as external user IDs
    const externalUserIds = waitListedUsers.map(user => user._id);
    notification.include_external_user_ids = externalUserIds;


    const notificationResponse = await client.createNotification(notification);

    console.log("notificationResponse: "+ notificationResponse);

}

export {
    initialize,
    sendMassPN,
    sendPNToPlayers
};
