# 테이블 뷰 안에 콜렉션 뷰 셀(nib사용 x)

### 배운점
    1. 테이블뷰셀에는 datasource와 delegate를 연결할 수 없다. 전 nib파일에서는 테이블 뷰 셀 swift
    파일에서 아울렛으로 콜렉션뷰를 연결한후 datasource = self, delegate = self를 해주었다
    이번에는 스토리보드 내에서 작업처리를 해주려 하니 테이블뷰에는 연결이 되던데 셀에는 안되는걸 알았다
    그 후 테이블뷰 셀 클래스에서 함수를 만들어서 datasource = self, delegate = self를 선언해서 
    tableview datasource부분에서 불러서 해결 해줬다 
    
    2. UICollectionViewDelegateFlowLayout으로 콜렉션뷰의 셀을 지정해주지 않으니 마음대로 콜렉션뷰의 크기가 자기 멋대로 날뛰었다 UICollectionViewDelegateFlowLayout를 설정해주고
    다시 시뮬레이터를 런을 해보니  호리젠탈과 버티컬 센터에 맞춰놨는데 출력이 되지 않았고 높이를 추가해주니 
    출력은 되었지만 원하는대로 나오지 않았다 크키를 잘 정해주고 앵커를 탑과 리딩을 잡아주었더니 해결은 되었다
    
    3. -- 재시도 flowlayout은 필요없었다 그냐 셀안으 ui의 레이아웃을 잘 조절하면 해결 되는 문제 였다
    
### 실패물 
<img src="https://user-images.githubusercontent.com/70513066/122235721-e12d8480-cef8-11eb-9515-267de54bb8e9.png" width="40%">
<img src="https://user-images.githubusercontent.com/70513066/122235680-d96de000-cef8-11eb-9561-0c6974310a32.png" width="40%">
<img src="https://user-images.githubusercontent.com/70513066/122236002-1a65f480-cef9-11eb-9ea4-7cb639a785d7.png" width="40%">


### 결과물
<img src="https://user-images.githubusercontent.com/70513066/122405722-3f22a080-cfbb-11eb-83fc-0d3f1aaeff10.png" width="40%">

