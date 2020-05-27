### 황경태
- email : forthezorba@gmail.com
- Github: https://github.com/forthezorba

## 프로젝트
### 나가구(NAGAGU)

'나만의 가구'란 뜻으로, 소비자와 공방을 연결하는 가구 관련 커뮤니티/스토어 플랫폼 입니다. '나가구'프로젝트는 회원가입/로그인/CRUD/좋아요 등 필수 기능들이 들어간 게시판 기반 웹앱입니다. 학원에서 5명이서 함께 만들었고, 수료 후 개인적으로 리팩토링을 거쳐 제가 직접 사용한 기술로 프로젝트를 새롭게 만들었습니다.
- (www.nagagu.ga)

## 이미지
<div>

<img src="https://user-images.githubusercontent.com/59009409/82997790-d0864400-a041-11ea-9919-65b66712b2a2.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/59009409/82997793-d1b77100-a041-11ea-8281-0164908c656a.jpg" width="200px">

<img src="https://user-images.githubusercontent.com/59009409/82998050-2d81fa00-a042-11ea-814b-534e66431bbf.jpg" width="200px">

</div>
<div>
   <img src="https://user-images.githubusercontent.com/59009409/82997797-d2e89e00-a041-11ea-8f82-6a782a65f07a.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/59009409/82997801-d3813480-a041-11ea-8ca9-1cca521c66b0.jpg" width="200px">
</div>

## 웹사이트 구성
- 커뮤니티 : 일반 회원들이 사진을 올리고 댓글로 의견을 교환할 수 있는 공간입니다.
- 스토어   : 공방사장님들은 상품을 등록하고 판매, 일반 회원들은 상품을 구매할 수 있는 공간입니다.
- 마이페이지 : 좋아요/업로드사진/수정/배송/댓글을 확인할 수 있는 공간입니다.
- 개인페이지(타인) : 커뮤니티에서 프로필 사진 클릭시 개인페이지로 이동, 해당 회원이 업로드/좋아요 한 사진과 팔로우 리스트를 볼 수 있습니다.

## 사용기술
- 회원가입 :  _bcrypt_ 를 이용해 암호화했습니다.
- 로그인 : 스프링 시큐리티와 자바메일을 통해 인증 합니다.
- 권한 : User객체를 사용, 관리자는 [ROLE_MEMBER, ROLE_WORKSHOP]을 일반 유저는 ROLE_MEMBER를 부여해 어노테이션을 통해 인증했습니다.
- 글쓰기 : 써머노트를 활용해 만들었습니다.
- 댓글 : 모달창에서 ajax를 통해 json형식으로 데이터를 주고 받습니다.
- 사진 : AWS S3를 통해 사진을 버켓내 폴더별로 저장하고 불러옵니다.
- DB : MyBatis와 AWS RDS 오라클을 통해 저장하고 불러옵니다.
- 서버 : AWS EC2 ubuntu를 이용했습니다.
- 라우팅/도메인 : AWS ROUTE를 이용, freenom 도메인과 연결했습니다.
- 장바구니/구매 : 장바구니/구매 페이지를 분리하여 다중선택/삭제가 가능하도록 구현했습니다.
- 결제 : import를 연동해 결제하도록 구현했습니다(test용으로 100원으로 가격설정했습니다. 금일 12시 금액 반환)
- 커뮤니티 상품등록(일반/후기) : jQuery Autocomplete를 이용해 후기를 선택하고 한 글자 이상 입력 시 구매이력에서 정보를 가져옵니다.

## 사이트 이용
- user (hwanghkt@naver.com / qwer1234!)
   - logout: 커뮤니티/스토어 목록(검색/필터링), 상세페이지 접근 가능
   - login : 커뮤니티 글/댓글 작성 및 좋아요/팔로우, 스토어에서 구매 가능
- workshop (hwanghkt@gmail.com / qwer1234!)
   - login : 회원가입/로그인 후 스토어 상품 등록 가능
