import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

export const helloWorldNew = functions.https.onCall((data, context) => {
//  functions.logger.info("Hello logs!", {structuredData: true});
  return ["Hello from Cloud Functions!"];
});

export const getUserData = functions.https.onCall( async (data, context) => {
  if (!context.auth) {
    return {"data": "Nenhum Usuário logado!"};
  }
  const snapshot = await admin.firestore().collection("user")
      .doc(context.auth.uid).get();
  return {"data": snapshot.data()};
});

export const addMessage = functions.https.onCall( async (data, context) => {
  console.log(data);
  const snapshot = await admin.firestore().collection("message").add(data);
  return {"success": snapshot.id};
});

export const onNewMessage = functions.firestore.document("/message/{id}")
    .onCreate((snapshot, context) => {
      const id = context.params.id;
      console.log(id);
    });
