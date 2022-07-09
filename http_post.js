import http from 'k6/http';

export default function () {
  const url = 'https://24g120ch84.execute-api.ap-northeast-2.amazonaws.com/checkout';
  // const payload = JSON.stringify({
  //   email: 'aaa',
  //   password: 'bbb',
  // });

  // const params = {
  //   headers: {
  //     'Content-Type': 'application/json',
  //   },
  // };

  http.post(url);
}
