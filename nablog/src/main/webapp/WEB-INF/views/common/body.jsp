<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<frameset cols="40%, 60%"><!-- //frameset: frame을 묶어주는 단위 / cols(열): 좌우로 배치 -->

  <frameset rows="25%, 75%"><!-- //row(행): 상하로 배치 -->

    <frame src="contents_of_frame1.html" /><!-- //25% -->

    <frame src="contents_of_frame2.html" /><!-- //75% -->

  </frameset>

  <frame name="content" src="contents_of_frame3.html" /> <!-- //name 속성에 content로 타깃을 지정할 수 있다. -->

<!--   <noframes>// 브라우저가  프레임을 지원하지 않는다면 noframes에 지정한 태그 출력된다.

    <body>// body 위에 지정하는 frameset

      <p>This frameset document contains:</p>

      <ul>

        <li><a href="contents_of_frame1.html">contents_of_frame1.html</a></li>

        <li><a href="contents_of_frame2.html">contents_of_frame1.html</a></li>

        <li><a href="contents_of_frame3.html">contents_of_frame1.html</a></li>

      </ul>

    </body>

  </noframes> -->

</frameset>

</head>

</html>