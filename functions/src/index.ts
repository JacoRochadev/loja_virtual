import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

import { CieloConstructor, Cielo, TransactionCreditCardRequestModel, EnumBrands } from 'cielo';

admin.initializeApp(functions.config().firebase);

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

const merchantid = functions.config().cielo.merchantid;
const merchantkey = functions.config().cielo.merchantkey;

const cieloParams: CieloConstructor = {
  merchantId: merchantid,
  merchantKey: merchantkey,
  sandbox: true, 
  debug: true 
}

const cielo = new Cielo(cieloParams);

exports.authorizeCreditCard = functions.https.onCall( async (data, context) => {
  if(data === null){
    return {"sucess": false, "error":{"code": -1, "message": "data is null"},};
  }
  if(!context.auth){return {"sucess": false, "error":{"code": -1, "message": "User is not found"},};}
  const userId = context.auth.uid;
  const snapshot = await admin.firestore().collection('users').doc(userId).get();
  const userData =snapshot.data() || {};

  console.log('iniciando authorizeCreditCard');

  let brand : EnumBrands;
  switch(data.brand){
    case "VISA":
            brand = EnumBrands.VISA;
            break;
        case "MASTERCARD":
            brand = EnumBrands.MASTER;
            break;
        case "AMEX":
            brand = EnumBrands.AMEX;
            break;
        case "ELO":
            brand = EnumBrands.ELO;
            break;
        case "JCB":
            brand = EnumBrands.JCB;
            break;
        case "DINERSCLUB":
            brand = EnumBrands.DINERS;
            break;
        case "DISCOVER":
            brand = EnumBrands.DISCOVERY;
            break;
        case "HIPERCARD":
            brand = EnumBrands.HIPERCARD;
            break;
        default:
          return{
            "sucess": false,
            "error":{
              "code": -1,
              "message": "Brand not found " + data.brand
            }
          };
  }

  const saleData: TransactionCreditCardRequestModel = {
    merchantOrderId: data.MerchantOrderId,
    customer: {
      name: userData.name,
      email: userData.email,
      identity: userData.cpf,
      identityType: 'CPF',
      address: {
        street: userData.address.street,
        number: userData.address.number,
        complement: userData.address.complement,
        zipCode: userData.address.zipCode.replace('-', '').replace('.', ''),
        city: userData.address.city,
        state: userData.address.state,
        country: 'BRA',
        district: userData.address.district
      }
    },
    payment: {
      currency: 'BRL',
      country: 'BRA',
      amount: data.amount,
      installments: data.installments,
      softDescriptor: data.softDescriptor.substring(0, 13),
      type: data.paymentType,
      capture: false,
      creditCard: {
        cardNumber: data.creditCard.cardNumber,
        holder: data.creditCard.cardHolderName,
        expirationDate: data.creditCard.expiryDate,
        securityCode: data.creditCard.cvvCode,
        brand: brand,
      }
    }
  }
  try {
    const transaction = await  cielo.creditCard.transaction(saleData);

    if(transaction.payment.status === 1){
      return {"sucess": true, "data": transaction}
    }else{
      let message = '';
      switch(transaction.payment.returnCode){
        case '5':
          message = 'Não Autorizada';
          break;
      case '57':
          message = 'Cartão expirado';
          break;
      case '78':
          message = 'Cartão bloqueado';
          break;
      case '99':
          message = 'Timeout';
          break;
      case '77':
          message = 'Cartão cancelado';
          break;
      case '70':
          message = 'Problemas com o Cartão de Crédito';
          break;
      default:
          message = transaction.payment.returnMessage;
          break;
      }
      return {
        "success": false,
        "status": transaction.payment.status,
        "error": {
            "code": transaction.payment.returnCode,
            "message": message
        }
      }
    }

  } catch (error) {
    return {"sucess": false, "error": error}; 
  }
 
});

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