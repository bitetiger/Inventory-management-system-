const axios = require('axios').default

exports.handler = async (event) => {
  console.log(event.Records)

let text = JSON.stringify(event.Records[0])

console.log(text)

const payload = {
        "MessageGroupId": body.messageId,
        "MessageAttributeProductId": body.ProductId,
        "MessageAttributeProductCnt": 10,
        "MessageAttributeFactoryId": body.FactoryId,
        "MessageAttributeRequester": "부산시 시장",
        "CallbackUrl": "https://6ntrcuns50.execute-api.ap-northeast-2.amazonaws.com/product/donut"
  }
  
  console.log(payload)
  
  axios.post('http://factory.p3.api.codestates-devops.be:8080/api/manufactures', payload)
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

};
