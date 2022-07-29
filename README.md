# AGIT (JSP 웹 게시판 프로젝트)

업데이트: AGIT (JSP 웹 게시판 프로젝트)

업데이트 날짜: 2022.07.29

자바 서버 페이지(JSP)로 만들어 본 웹 게시판 프로젝트입니다. 

http://choijiyong.cafe24.com/main.jsp

# 설명

나동빈님 유튜브 영상 중 JSP 게시판 만들기 강좌를 참고로 새로운 기능들을 직접 추가해 구현한 게시판 사이트입니다.

하고 싶은 이야기가 있으면 게시판을 통해 글로 작성하여 사람들과 소통할 수 있습니다.

# 사용한 기술

* IDE: Eclipse

* DBMS: MySQL 8.0

* WAS: Apache Tomcat 9.0

* Frontend: BootStrap 3, HTML, CSS

* Backend: Java

# 기능

* 회원가입 및 로그인

* 회원정보 수정 및 탈퇴

* 게시글 CRUD

* 게시글 추천 및 조회 기능 표시

* 댓글 CRUD

* 게시글 검색

* 게시판 페이징

# ERD

![BBS ERD](https://user-images.githubusercontent.com/87258054/181737016-89eb024e-466b-428a-8bfd-db9483ee6065.png)

# 메인화면

![메인화면](https://user-images.githubusercontent.com/87258054/181738144-8038ce21-a53b-4142-9146-3ec60a5615cc.PNG)

# 게시판 화면

![게시판화면](https://user-images.githubusercontent.com/87258054/181738259-c7925e65-e629-4996-a7e8-cd8b9fe1e931.PNG)

# 게시글 화면

![본인글추천목록수정삭제댓글쓰기](https://user-images.githubusercontent.com/87258054/181738302-1eca4cf5-dde6-417b-a41c-a520b9b99d4c.PNG)

# 직접 구현한 기능

* 댓글 목록 구현, 댓글 수정 및 삭제

* 게시글 추천

* 게시글 조회수

* 회원 정보 수정 및 탈퇴

* 게시판 페이징 처리

* 사용자 이름, 게시글 제목에 해당하는 검색

# 더 추가해 보고 싶은 기능 (진행 중)

* 댓글 및 추천 기능을 비동기식으로 구현

* 대댓글 기능

* 게시글 제목 옆에 댓글 개수 표현

* 사진이나 동영상 업로드 기능

# 배운 점

JSP 웹 사이트 게시판 프로젝트를 하며 많은 것을 배웠습니다. Tomcat이 웹 서버와 연동하여 실행할 수 있는 자바 환경을 제공해주는 것을 알게 되었습니다. 또한 MySQL을 사용하여 
사용자들의 정보를 저장해주고 불러오는 데이터베이스에 대해서도 알게 되었습니다. 또한 메인 화면이나 게시판 화면을 구성하면서 사용자들에게 보여지는 프론트엔드에도 관심이 조금
생기게 되었습니다. 만들고 나서 카페24 사이트에서 톰캣 호스팅을 하는 과정에서도 서버를 구축하고 운영하는 데에도 엄청난 노력이 필요하다는 것을 깨달았습니다. 사진 업로드 기능이나
대댓글 기능, 작성글 옆에 댓글 수 표시 기능 등을 계속하여 업데이트 하겠습니다.
