-- 테이블 삭제
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE MENU CASCADE CONSTRAINTS;
DROP TABLE REPLY CASCADE CONSTRAINTS;
DROP TABLE ATTACHFILE CASCADE CONSTRAINTS;

--시퀀스 삭제
DROP SEQUENCE SEQ_BOARD_BNO;
DROP SEQUENCE SEQ_MENU_MENU_CATE_NO;
DROP SEQUENCE SEQ_REPLY_REPLY_NO;
DROP SEQUENCE SEQ_ATTACHFILE_FILE_NO;

--멤버 테이블 생성
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY,
    PWD VARCHAR2(60) NOT NULL,
    NICK_NM VARCHAR2(15),
    MAG_YN CHAR(1) CHECK ( MAG_YN IN ('Y', 'N') ) -- Y: 여 N: 부
);

--멤버 테이블 코멘트
COMMENT ON COLUMN MEMBER.ID IS '아이디';
COMMENT ON COLUMN MEMBER.PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.NICK_NM IS '닉네임';
COMMENT ON COLUMN MEMBER.MAG_YN IS '운영자 여부';

--멤버 테이블 데이터
INSERT INTO MEMBER VALUES ('admin11', 'admin11', '나츠키', 'Y');

--메뉴 관리 테이블 생성
CREATE TABLE MENU(
    MENU_CATE_NO NUMBER PRIMARY KEY,
--    CATE_YN CHAR(1) CHECK ( CATE_YN IN ('Y', 'N') ), -- Y: 여 , N: 부
    MENU_CATE_REF NUMBER DEFAULT 0,
    MENU_TIT VARCHAR2(30) NOT NULL
);

--메뉴 테이블 자기 참조 제약조건 추가
ALTER TABLE MENU ADD CONSTRAINT MENU_REF_FK FOREIGN KEY (MENU_CATE_REF) REFERENCES MENU (MENU_CATE_NO);

COMMENT ON COLUMN MENU.MENU_CATE_NO IS '메뉴 카테고리 번호';
COMMENT ON COLUMN MENU.MENU_CATE_REF IS '메뉴 카테고리 참조번호';
--COMMENT ON COLUMN MENU.CATE_YN IS '카테고리 여부';
COMMENT ON COLUMN MENU.MENU_TIT IS '메뉴 제목';

--시퀀스 생성
CREATE SEQUENCE SEQ_MENU_MENU_CATE_NO;

--메뉴 데이터
INSERT INTO MENU VALUES( 0, 0, '메인' );
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 0, '메뉴 메인카테고리1');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 1, '카테고리1-1');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 1, '카테고리1-2');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 1, '카테고리1-3');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 0, '메뉴 메인카테고리2');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 5, '카테고리2-1');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 5, '카테고리2-2');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 5, '카테고리2-3');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 0, '메뉴 메인카테고리3');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 9, '카테고리3-1');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 9, '카테고리3-2');
INSERT INTO MENU VALUES( SEQ_MENU_MENU_CATE_NO.NEXTVAL, 9, '카테고리3-3');

--메뉴 테이블 확인
SELECT * FROM MENU;
SELECT * FROM MENU WHERE MENU_CATE_REF =0 AND MENU_CATE_NO != 0;

-- 게시판 테이블 생성   
CREATE TABLE BOARD(
    B_NO NUMBER PRIMARY KEY,
    MENU_CATE_NO NUMBER(10) NOT NULL,
    B_TITLE VARCHAR2(300) NOT NULL,
    B_CNT VARCHAR2(1000) NOT NULL,
--    B_ORFILE VARCHAR2(50),
--    B_REFILE VARCHAR2(50),
    B_DATE DATE DEFAULT SYSDATE NOT NULL,
    B_TAG VARCHAR2(95),
    B_VIEW NUMBER DEFAULT 0,
    RGBD_ID VARCHAR2(20) NOT NULL,
    B_USYN CHAR(1) DEFAULT 'Y'  CHECK ( B_USYN IN ('Y', 'N') ),
    CONSTRAINT B_ID_FK FOREIGN KEY (RGBD_ID) REFERENCES MEMBER (ID),
    CONSTRAINT MENU_CATE_NO_FK FOREIGN KEY (MENU_CATE_NO) REFERENCES MENU (MENU_CATE_NO)
);

--게시판 테이블 코멘트
COMMENT ON COLUMN BOARD.B_NO IS '게시글 번호';
COMMENT ON COLUMN BOARD.MENU_CATE_NO IS '메뉴 카테고리 번호';
COMMENT ON COLUMN BOARD.B_TITLE IS '게시글 제목';
COMMENT ON COLUMN BOARD.B_CNT IS '게시글 내용';
--COMMENT ON COLUMN BOARD.B_ORFILE IS '첨부파일 원본이름';
--COMMENT ON COLUMN BOARD.B_REFILE IS '첨부파일 저장이름';
COMMENT ON COLUMN BOARD.B_DATE IS '게시글 작성일자 ';
COMMENT ON COLUMN BOARD.B_TAG IS '게시글 태그';
COMMENT ON COLUMN BOARD.B_VIEW IS '게시글 조회수';
COMMENT ON COLUMN BOARD.RGBD_ID IS '게시글 작성자';
COMMENT ON COLUMN BOARD.B_USYN IS '게시글 사용여부';

--시퀀스 생성
CREATE SEQUENCE SEQ_BOARD_BNO;

--게시판 샘플 내용
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'샘플 데이터를 작성해볼려고 해요 '
           , '달고나가 진짜 맛있다. 왜 이렇게 단게 땡기는 것인지 모르겠다 정말 맛있다. 달고나 빵 먹고 싶은데 '
           ,'2020-01-12'
           ,'샘플,달고나,데이터'
           ,5
           ,'admin11'
           ,'Y'
    );

INSERT INTO BOARD 
VALUES( 
          SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'이 땅에서 사셨던 역사적 예수와 십자가의 죽음을'
           , '누가 될까요? 어떤 사람이 돼야 할까요? 그 전에 먼저 대통령 비서실장이라는 공직에 대해 간단히 알아보겠습니다. 이승만 대통령 시절 경무대 비서실 '
           ,'2020-02-12'
           ,'예수,십자가'
           ,6
           ,'admin11'
           ,'Y'
    );
    
INSERT INTO BOARD 
VALUES(  
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'첫번째 리뷰어가 되어주세요.'
           , '경북 구미의 한 카페 신입사원과 사장님의 거침없는 입담 속에서 서로를 이해해 가는 시간을 가져보았습니다.구미 채미정에 오셔서 꼭 일편단심의 의미를 '
           ,'2020-03-11'
           ,'리뷰어,첫번째,일편단심,입담'
           ,1
           ,'admin11'
           ,'Y'
    );
    
INSERT INTO BOARD 
VALUES(  
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'다음을 가리키는 말이다.'
           , '하룻밤 자고 나면 사라지는 꿈처럼 너를
								oh~ 잊게될까 두려워져 무심히 널 떠올리게 되면 불안해지는 맘 어떻게 해야하니 안녕 이제는 안녕 이 말 도저히 할
								수가 없어 '
           ,'2020-03-19'
           ,'하룻밤,꿈,안녕,맘'
           ,10
           ,'admin11'
           ,'Y'
    );
    
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'전 세계에서 아이디어를 가장 많이 모아 놓은'
           , '액션 정국이는 댄브 턴 동작을 완벽하게 하고 싶어해서 안무가에게 계속 물어보고 저 한동작을 연습하고 또 연습했다고 '
           ,'2020-03-22'
           ,'아이디어,정국'
           ,7
           ,'admin11'
           ,'Y'
    );

INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'천고에 사라지지 않는 것이다?'
           , '인류의 역사를 꾸며 내려온 동력은 바로 이것이다 이성은 투명하되 얼음과 같으며 지혜는 날카로우나 갑 속에 든 칼이다 청춘의 끓는 피가 아니더면
								인간이 얼마나 쓸쓸하랴? 얼음에 싸인 만물은 얼음이 '
           ,'2020-04-01'
           ,''
           ,20
           ,'admin11'
           ,'Y'
    );
    
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'인간이 얼마나 쓸쓸하랴?'
           , '구하기
								위하여서 그리하였는가? 아니다 그들은 커다란 이상 곧 만천하의 대중을 품에 안고 그들에게 밝은 길을 찾아 주며
								그들을 행복스럽고 평화스러운 곳으로 인도하겠다는 커다란 이상을 품었기 때문이다 그러므로 그들은 길지 아니한 목숨을
								사는가 '
           ,'2020-04-12'
           ,''
           ,11
           ,'admin11'
           ,'Y'
    ); 
    
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'노년에게서 구하지 못할 바이며'
           , '아름답고 소담스러운 열매를 맺어 우리
								인생을 풍부하게 하는 것이다 보라 청춘을 ! 그들의 몸이 얼마나 튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에
								무엇이 타오르고 있는가? 우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 그것은 웅대한 관현악이며
								미묘한 교향악이다 뼈 끝에 '
           ,'2020-05-07'
           ,'노년,청춘,교향악'
           ,2
           ,'admin11'
           ,'Y'
    ); 

INSERT INTO BOARD 
VALUES( 
             SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'동력은 바로 이것이다'
           , '천고에	사라지지 않는 것이다 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 창공에 반짝이는 뭇 별과 같이 산야에 피어나는 군영과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니 인생에 가치를 주는 원질이 되는 것이다 그들은 앞이 긴지라 착목한는 곳이 원대하고 그들은 피가 더운지라 실현에 대한 자신과 용기가 있다 그러므로 그들은 이상의 보배를 능히 품으며 그들의 이상은 아름답고 소담스러운 열매를 맺어 우리 인생을 풍부하게 하는 것이다 보라 청춘을 ! 그들의 몸이 얼마나 튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 '
           ,'2020-7-12'
           ,'동력,천고,창공'
           ,4
           ,'admin11'
           ,'Y'
    ); 
  
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'무엇이 타오르고 있는가'
           , ' 이성은 투명하되 얼음과 같으며 지혜는 날카로우나 갑 속에 든 칼이다 청춘의 끓는 피가 아니더면 인간이 얼마나 쓸쓸하랴? 얼음에 싸인 만물은 얼음이 있을 뿐이다 그들에게 생명을 불어 넣는 것은 따뜻한 봄바람이다 풀밭에 속잎나고 가지에 싹이 트고 꽃 피고 새 우는 봄날의 천지는 얼마나 기쁘며 얼마나 아름다우냐? 이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 인생에 따뜻한
								봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이
								피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면  '
           ,'2020-7-25'
           ,'이성,사랑,생명'
           ,9
           ,'admin11'
           ,'Y'
    );
    
INSERT INTO BOARD 
VALUES(
             SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'이것은 테스트라는 것입니다'
           , '시험, 혹은 실험. 프로토타입 등의 무언가를 검사 혹은 시험한다는 의미로도 쓰인다. '
           ,'2020-8-1'
           ,''
           ,3
           ,'admin11'
           ,'Y'
    );    

INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 

--여기부터는 그저 복붙일 뿐임
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    );
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 
INSERT INTO BOARD 
VALUES( 
            SEQ_BOARD_BNO.NEXTVAL
           ,1
           ,'대개 코딩이나 디자인된 내용이 일반 컴에서도 무난하게 돌아가는지'
           , '갑자기 튕긴다거나 예상치 못했던 기능, 예컨데 불필요한 연산을 마구 한다던가 등을 찾기 위해 초기엔 프로토타입인 알파에 이어'
           ,'2020-8-11'
           ,''
           ,2
           ,'admin11'
           ,'Y'
    ); 

--게시판 조회
SELECT * FROM BOARD;

--댓글 테이블 생성
CREATE TABLE REPLY(

    REPLY_NO NUMBER PRIMARY KEY,
    REPLY_ID VARCHAR2(20),
    REPLY_CNT VARCHAR2(80) NOT NULL,
    REPLY_LOCK CHAR(1) CHECK( REPLY_LOCK IN ('Y', 'N') ),
    B_NO NUMBER,
    REPLY_REF NUMBER,
    REPLY_SRT NUMBER,
    REPLY_DATE DATE DEFAULT SYSDATE,
    REPLY_USYN CHAR(1)  CHECK( REPLY_USYN IN ('Y', 'N') ),
--    MENU_ID VARCHAR2(10),
    CONSTRAINT REPLY_ID_FK FOREIGN KEY (REPLY_ID) REFERENCES MEMBER (ID),
    CONSTRAINT B_NO_FK FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
 
);
--댓글 테이블 자기 참조 제약조건 추가
ALTER TABLE REPLY ADD CONSTRAINT REPLY_REF_FK FOREIGN KEY (REPLY_REF) REFERENCES REPLY (REPLY_NO);

--댓글 테이블 코멘트
COMMENT ON COLUMN REPLY.REPLY_NO IS '댓글 번호';
COMMENT ON COLUMN REPLY.REPLY_ID IS '댓글 작성자 아이디';
COMMENT ON COLUMN REPLY.REPLY_CNT IS '댓글 내용';
COMMENT ON COLUMN REPLY.REPLY_LOCK IS '댓글 비밀글 여부';
COMMENT ON COLUMN REPLY.B_NO IS '게시판 글 번호';
COMMENT ON COLUMN REPLY.REPLY_REF IS '참조 글 번호';
COMMENT ON COLUMN REPLY.REPLY_SRT IS '댓글 순서';
COMMENT ON COLUMN REPLY.REPLY_DATE IS '댓글 작성일자';
COMMENT ON COLUMN REPLY.REPLY_USYN IS '댓글 사용여부';
--COMMENT ON COLUMN REPLY.MENU_ID IS '메뉴 아이디';

--시퀀스 생성
CREATE SEQUENCE SEQ_REPLY_REPLY_NO;

--샘플 데이터
INSERT INTO REPLY VALUES ( SEQ_REPLY_REPLY_NO.NEXTVAL, 'admin11', '첫번째 댓글이에요', 'N', 12, 1 , 1, SYSDATE, 'Y');
INSERT INTO REPLY VALUES ( SEQ_REPLY_REPLY_NO.NEXTVAL, 'admin11', '두번째 댓글이에요', 'N', 12, 1 , 2, SYSDATE, 'Y');
INSERT INTO REPLY VALUES ( SEQ_REPLY_REPLY_NO.NEXTVAL, 'admin11', '세번째 댓글이에요', 'N', 12, 2 , 1, SYSDATE, 'Y');
INSERT INTO REPLY VALUES ( SEQ_REPLY_REPLY_NO.NEXTVAL, 'admin11', '네번째 댓글이에요', 'N', 12, 4 , 1, SYSDATE, 'Y');
INSERT INTO REPLY VALUES ( SEQ_REPLY_REPLY_NO.NEXTVAL, 'admin11', '다섯번째 댓글이에요', 'N', 12, 4 , 2, SYSDATE, 'Y');

--댓글 조회
SELECT * FROM REPLY ;

--첨부파일 저장 테이블 생성
CREATE TABLE ATTACHFILE (
    FILE_NO NUMBER PRIMARY KEY,
    B_REFILE VARCHAR2(50), 
    FILE_NAME VARCHAR2(50),
    UPLOAD_PATH VARCHAR2(70),
    UUID VARCHAR2(50),
    IMAGETYPE CHAR(1) CHECK ( IMAGETYPE IN('T','F')),
    B_NO NUMBER,
    CONSTRAINT ATTACHFILE_B_NO_FK FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
);

--첨부파일 저장 테이블 코멘트
COMMENT ON COLUMN ATTACHFILE.FILE_NO IS '첨부파일 번호';
COMMENT ON COLUMN ATTACHFILE.B_REFILE IS '저장이름';
COMMENT ON COLUMN ATTACHFILE.FILE_NAME IS '원본파일 이름';
COMMENT ON COLUMN ATTACHFILE.UPLOAD_PATH IS '업로드 경로';
COMMENT ON COLUMN ATTACHFILE.UUID IS 'UUID값';
COMMENT ON COLUMN ATTACHFILE.IMAGETYPE IS '이미지 여부'; 
COMMENT ON COLUMN ATTACHFILE.B_NO IS '게시글 번호';

--시퀀스 생성
CREATE SEQUENCE SEQ_ATTACHFILE_FILE_NO;

--시퀀스 조회
SELECT * FROM USER_SEQUENCES;

--커밋
COMMIT;





--데이터 크기 설정 참고 
--SELECT LENGTH('테스트') AS koleng,
--       LENGTH('abc') AS ensoleng,
--       LENGTH('ABC') AS endaeleng,
--       LENGTH('123') AS numleng,
--       LENGTHB('테스트') AS bykoleng,
--       LENGTHB('abc') AS byensoleng,
--       LENGTHB('ABC') AS byendaeleng,
--       LENGTHB('123') AS bynumleng,
--       LENGTHB(',') AS Ccommaleng
--    FROM dual;
--    
--CREATE TABLE TEST (
--    KO VARCHAR2(3),
--    EN VARCHAR2(3)
--);

--INSERT INTO TEST VALUES('abcd','1234');

--DROP TABLE TEST;

