<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- sidemenu -->

<style>
.nav {
	float: left;
	width: 150px;
	padding: 20px;
	border-right: thin solid;
	border-right-color: lightgray;
	display: inline-block;
}
</style>

<div class="nav">

		<div>
			<a href="../mypage/admAllList.jsp">회원 찾기</a>
		</div>
		<div>
			<a href="/talkdog/Mypage/masReqConfirm.do">전문가 인증 관리</a>
		</div>
		<div>
			<a href="/talkdog/Order/OrderList.do">주문관리</a>
		</div>
		<div>
			<a href="/talkdog/Qna/listWaiting.do?pageNum=1&category=">답변 대기 문의글</a>
		</div>
	</div>