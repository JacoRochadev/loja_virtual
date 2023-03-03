import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

exports.helloWorld = functions.https.onCall((data, context) => {
  return {data: "Hello from Firebase!"};
});

exports.getUserData = functions.https.onCall( async (data, context) => {
  if (!context.auth) {
    return {"data": "nenhum usuario logado"};
  }
  const snapshot = await admin.firestore().collection('users').doc(context.auth.uid).get();

  return {"data": snapshot.data()};
});

exports.addMessage = functions.https.onCall( async (data, context) => {
  console.log(data);

    const snapshot = await admin.firestore().collection("messages").add(data);

    return {"success": snapshot.id};
});

exports.onNewOrder = functions.firestore.document('orders/{orderId}').onCreate(async (snapshot, context) => {
  const orderId = context.params.orderId;
  console.log(orderId);
});