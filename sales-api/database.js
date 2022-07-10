const mysql = require('mysql2/promise');
require('dotenv').config()

// 환경변수 설정에 따라서 접속한다.
const {
  HOSTNAME: host,
  USERNAME: user,
  PASSWORD: password,
  DATABASE: database
} = process.env;

// DB와 연결하는 역할을 하는 함수
const connectDb = async (req, res, next) => {
  try {//conn 이라는 변수는 connection 정보, pool이 conn안에 들어간다. pool은 접속된 instance를 의미하기도 한다.
    req.conn = await mysql.createConnection({ host, user, password, database })
    next()
  }
  catch(e) {
    console.log(e)
    res.status(500).json({ message: "데이터베이스 연결 오류" })
  }
}


// getStock SQL 커리
const getProduct = (sku) => `
  SELECT BIN_TO_UUID(product_id) as product_id, name, price, stock, BIN_TO_UUID(factory_id), BIN_TO_UUID(ad_id)
  FROM product
  WHERE sku = "${sku}"
`
// setStock SQL 커리
const setStock = (productId, stock) => `
  UPDATE product SET stock = ${stock} WHERE product_id = UUID_TO_BIN('${productId}')
`

// increaseStock
const increaseStock = (productId, incremental) => `
  UPDATE product SET stock = stock + ${incremental} WHERE product_id = UUID_TO_BIN('${productId}')
`

module.exports = {
  connectDb,
  queries: {
    getProduct,
    setStock,
    increaseStock
  }
}