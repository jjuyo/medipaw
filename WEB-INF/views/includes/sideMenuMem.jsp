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
			<a href="/talkdog/mypage/memMypage.jsp">내 정보</a>
		</div>
		<div>
			<a href="#">내 프로필</a>
		</div>
		<div>
			<a href="/talkdog/mypage/memMasReq.jsp">전문가 등록 신청</a></div>
			
		<div><a href="/talkdog/Order/OrderList.do">주문 내역 조회</a></div>
		<div><a href="/talkdog/Comm/CommList.do?pageNum=1&type=&keyword=&catNo=0&sid=${sessionScope.sid }">내 커뮤니티 내역</a></div>
		<div><a href="/talkdog/Qna/listMine.do?pageNum=1&category=">내 문의글 내역</a></div>
		<div><a href="/talkdog/product/myReview.jsp">내 리뷰 내역</a></div>
		<div><a href="/talkdog/Comm/CmreList.do?pageNum=1&type=&keyword=&catNo=0&sid=${sessionScope.sid }">내 댓글 내역</a></div>
	</div>