# 다이나믹 테이블 뷰 

## 공부이유 : 오토레이아웃과 테이블뷰를 컨트롤함에 있어 부족함을 느껴 공부를 다시해보기로 함
#### 배운점
  1. 기존에는 스토리보드 하나에 뷰컨트롤러에 테이블뷰부터 셀까지 모두 만든 후 작업을 하였지만 이번에는 nib을 이용하여 셀에 대한 디자인을 해보았고 스택뷰의 아이템을 일정하게 맞추는법을 추가로 알게되었다 
  2. 셀을 일정하게만 뽑을 수 있었고 셀 크기를 각각 다르게 표기 하기 위해서는 컨테이너뷰를 이용해서 영역을 하나 더 설정해 주며 작업을 했는데 이번 결과물을 이용해 좀 더 간편하고 빠르게 셀을 컨트롤 할 수 있을꺼같은 자신감이 들었다
  3. 오토레아이웃에 대한 이해도가 올랐다 그냥 무 지성으로 앵커를 박았다면 왜 이 앵커가 필요하고 빨간색으로 오토레이아웃이 제대로 잡히지 않았을때에 대한 이유를 명확하게 알게 되었다
  4. 오토레이아웃은 뷰의 위치뿐만 아니라 뷰의 크기도 같이 정의해줘야한다는 기본적인 부분을 잘 알지 못하고 무작정 앵커만 박은것에 대해 반성하게 되었다
  
#### 작업방법 
  1. 메인스토리뷰에 테이블뷰를 생성 탑,리딩,트레일링, 바텀에 앵커를 잡아준다 
  2. xib파일을 만들어 테이블뷰에서 델리게이트 패턴으로 보여질 셀의 UI를 작업해준다.
  3. 셀의 코드를 입력해줄 스위프트 파일을 만들고 셀을 연결시킨 후 셀에 요소를 IBAction으로 연결해준다.
  4. 테이블뷰가 연결된 viewController 스위프트 파일에 테이블뷰 데이터소스와 델리케이트를 상속을 받아주고 만들어 놓은 텍스트 어레이의 개수만큼 출력 시키고 셀의 텍스트라벨에 indexpath.row로 순서대로 넣어준다

# 결과물
<img src="https://user-images.githubusercontent.com/70513066/121855937-dd4e0680-cd2e-11eb-83c8-8e51543ea2b1.png" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>
<img src="https://user-images.githubusercontent.com/70513066/121856217-37e76280-cd2f-11eb-9979-cb630e7e6531.png" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>
