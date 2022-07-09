const axios = require('axios').default

exports.handler = async (event) => {
  console.log(event.Records)

  // for (const record of event.Records) {
  //   console.log("Message Body: ", record.body);
  // }


let body = JSON.stringify(event.Records)
console.log(body)

const payload = {
        "MessageGroupId": body.messageId,
        "MessageAttributeProductId": body.ProductId,
        "MessageAttributeProductCnt": 10,
        "MessageAttributeFactoryId": body.FactoryId,
        "MessageAttributeRequester": "부산시 시장",
        "CallbackUrl": "https://24g120ch84.execute-api.ap-northeast-2.amazonaws.com/product/donut"
  }
  
  axios.post('http://factory.p3.api.codestates-devops.be:8080/api/manufactures', payload)
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

};
