# 테이블 뷰 안에 콜렉션 뷰 셀

### 배운점
    1. 테이블뷰와 콜렉션뷰의 활용하는 방법이 한가지 늘었다 
    2. nib을 이용한 방법을 다시 한번 사용하면서 복습이 되었다 
    
#### 작업 방법 
    1. 앱 실행시 처음 나오는 뷰페이지 스토리보드에 테이블 뷰를 생성 -> 아울렛으로 연결해준다 
    2. 테이블뷰에서 재사용 될 테이블뷰 셀의 nib파일과 siwft파일을 생성해준다 -> nib파일에 생성한 셀파일에 identyfier를 정해주고 콜렉션 뷰 를 생성 스위프트 파일에서 아울렛으로 연결 해준다 
    3. 테이블뷰 스위프트 파일에서만 사용 할 것이니 static 상수 identyfier를 만들고 nib에서 정해준 identyfier의 이름과 동일 하게 선언 nib파일을 사용할 것이니 UINib을 반환하는 static 메서드를 생성한다 awakeFromNib()에 닙이 생성될때 콜렉션뷰셀의 nib파일이 나오게한다 
    4. 콜렉션 뷰에서 사용될 재사용 셀을 nib파일과 swift파일을 생성해준다 2번과 마찬가지로 identyfier를 정해준다 그리고 셀에 표시될 UI요소들을 넣어주고 오토레이아웃을 잡아준다
    5. 3번과 마찬가지로 identyfier와 nib에 대한 func을 만들어 준다 
    

### 결과물
![ezgif com-video-to-gif](https://user-images.githubusercontent.com/70513066/122068183-25ece900-ce2f-11eb-80da-dc9a35a2ebcf.gif)

