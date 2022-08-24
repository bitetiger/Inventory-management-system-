# Inventory-management-system
- MSA 기반 자동 재고 확보 시스템으로 고객이 API를 통해서 재고를 요청하면 재고 유무에 따라 감소와 재고 요청이 자동으로 진행
- Terraform을 통해 리소스 생성가능
![image](https://user-images.githubusercontent.com/89952061/186431058-d76a82c3-f3ac-4649-b6a1-3cfcbf661f8f.png)
- API를 통해 도넛을 주문하면 재고 감소와 함께 구매가 완료됨
- 만약 재고가 없을 경우, 제조 공장에 재고를 요청

### Lambda server
- 고객의 주문을 처리하는 Lambda 함수이며 DB와 통신하여 재고 수량을 조절
- 재고 부족시 SNS로 신규 재고 10개를 추가 요청

### SNS stock_empty
- Lambda로 부터 재고 요청 메시지를 받아 SQS를 타겟으로 전달

### SQS stock_queue, dead_letter_queue
- SNS로부터 stock_queue가 재고 요청 메시지를 전달받아 DB에 재고 요청하는 stock_lambda가 메시지를 소비
- stock_lambda가 메시지를 소비하지 못할 경우, dead_letter_queue로 전달되어 

### Lambda stock_lambda
- SQS로 부터 메시지를 전달받아 DB 재고를 증가시키는 역할
- axios 라이브러리를 통해서 HTTP POST 요청

