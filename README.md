### 황경태
- email : forthezorba@gmail.com
- Github: https://github.com/forthezorba

## 프로젝트
### 나가구(NAGAGU)

'나만의 가구'란 이름으로, 회원가입/로그인/CRUD/좋아요 등 필수 기능들이 들어간 졸업 프로젝트 입니다. 학원에서 5명이서 함께 만들었고, 수료 후 개인적으로 리팩토링을 거쳐 제가 직접 사용한 기술로 프로젝트를 새롭게 만들었습니다.
- (www.nagagu.ga)

## 사용기술
- 로그인/회원가입 : 스프링 시큐리티와 bcrypt를 이용해 암호화했습니다.
- 회원가입 : 자바메일을 통해 승인인증을 합니다.
- 권한 : User객체를 Custom하여 관리자에는 [ROLE_MEMBER, ROLE_WORKSHOP]을, 일반 유저는 ROLE_MEMBER를 부여해 어노테이션을 통해 인증했습니다.
- 글쓰기 : 써머노트를 활용해 만들었습니다.
- 댓글 : 모달창에서 ajax를 통해 json형식으로 데이터를 주고 받습니다.
- 사진 : AWS S3를 통해 사진을 버켓내 폴더별로 저장하고 불러옵니다.
- DB : MyBatis와 AWS RDS 오라클을 통해 저장하고 불러옵니다.
- 서버 : AWS EC2 ubuntu를 이용했습니다.
- 라우팅/도메인 : AWS ROUTE를 이용, freenom 도메인과 연결했습니다.
- 장바구니/결제 : import를 연동해 사용하도록 만들었습니다.
