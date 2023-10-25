<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    
<head>
<style>
  .flex-container {
    display: flex;
    align-items: center;
  }

  .flex-container > div {
    flex: 1; /* 동일한 너비를 가집니다. */
  }
  #goLogout {
    background-color: transparent;
    color: #e74c3c; /* 빨간색 */
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
   
  }
#goLogin {
    background-color: transparent;
    color: gray;
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
}

#goJoinPage {
    background-color: transparent;
    color: #87CEEB; /* 더 진한 하늘색 */
    border: none; /* 더 진한 하늘색의 테두리 */
    border-radius: 5px;
    padding: 5px 10px;
}
</style>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>medipaw</title>
</head>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>medipaw</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="/resources/img/favicon.png" rel="icon">
  <link href="/resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="/resources/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="/resources/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="/resources/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="/resources/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="/resources/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Medilab
  * Updated: Sep 18 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/medilab-free-medical-bootstrap-theme/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Top Bar ======= -->
  <div id="topbar" class="d-flex align-items-center fixed-top">
    <div class="container d-flex justify-content-between">
      <div class="contact-info d-flex align-items-center">
        <i class="bi bi-envelope"></i> <a href="mailto:contact@example.com">contact@example.com</a>
        <i class="bi bi-phone"></i> +1 5589 55488 55
      </div>
      
      
       <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container-fluid">



<sec:authorize access="isAnonymous()">
	<div>
	    로그인을 해주세요!
    <a href="/genStaff/login" id="goLogin">병원관계자 로그인</a>
    <a href="/customLogin" id="goLogin" >회원 로그인</a>
    <a href="/genStaff/join" id="goJoinPage">병원관계자 가입</a>
    <a href="/member/terms"   id="goJoinPage">회원가입</a>
	   <!--  <button id="goLogin">login</button>
	    <button id="goJoinPage">join</button> -->
	</div>
</sec:authorize>


<sec:authorize access="isAuthenticated()">
  <div style="display: flex; align-items: center;">
    <span><sec:authentication property="principal.username"/></span>
    <span>님 환영합니다!</span>
      <a href="/member/myPage">My Page</a>
    
    <!-- security적용할 땐 action을 무조건! /login으로 해야 함, username, Password도 무조건! -->
    <form role="form"  action="/customLogout" method="post" style="margin-left: 10px;">
      <fieldset>
        <!-- Change this to a button or input when using this as a form -->
        <input type="submit" id="goLogout" value="Logout">
      </fieldset>
      <input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }"><!-- 서버에서 들어오는 정보 -->
      <!-- 서버에서 _csrf의 내용을 받아오면서 침입인 건지 아닌지를 판별함 -->
    </form>
  </div>
</sec:authorize>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

  
        </div>

    </section><!-- End About Section -->
      
    </div>
  </div>

<sec:authorize access="hasRole('ROLE_ADMIN')">
  <header id="header" class="fixed-top admin-header">
    <!-- 관리자용 헤더 내용 -->
      <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="/">MediPaw Admin</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="resources/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto active" href="/">Home</a></li>
          <li><a class="nav-link scrollto" href="/member/list">회원관리</a></li>
          <li><a class="nav-link scrollto" href="/admin/staffList">병원관계자관리</a></li>
          <li><a class="nav-link scrollto" href="/petmap">petmap</a></li>
          <li><a class="nav-link scrollto" href="#doctors">Doctors</a></li>
          <li><a class="nav-link scrollto" href="/reserv/listAdm">예약관리</a></li>
          <li><a class="nav-link scrollto" href="/treat/listAdm">진료관리</a></li>
          <li class="dropdown"><a href="#"><span>게시판 관리</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="#">자랑 게시판</a></li>
              <li><a href="/siljong/list">실종 신고 게시판</a></li>
              <li><a href="/boonyang/list">분양 게시판</a></li>
              <li><a href="#">커넥팅 게시판</a></li>
            </ul>
          </li>
          <li><a class="nav-link scrollto" href="/faq/list">FAQ</a></li>
          <li><a class="nav-link scrollto" href="#">공지사항</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

      <a href="#appointment" class="appointment-btn scrollto"><span class="d-none d-md-inline">Make an</span> Appointment</a>

    </div>
  </header><!-- End Header -->
    <!-- 예를 들어, 다른 로고, 다른 메뉴 등을 여기에 추가 -->
  </header>
</sec:authorize>

<sec:authorize access="not hasRole('ROLE_ADMIN')">
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="/">MediPaw</a></h1>
      <!-- 나머지 헤더 내용 -->
        <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="/">MediPaw</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="resources/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto active" href="/">Home</a></li>
          <li><a class="nav-link scrollto" href="/petmap">petmap</a></li>
          <li><a class="nav-link scrollto" href="#services">Services</a></li>
          <li><a class="nav-link scrollto" href="#departments">Departments</a></li>

          <li class="dropdown"><a href="#"><span>게시판 관리</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="#">자랑 게시판</a></li>
              <li><a href="/siljong/list">실종 신고 게시판</a></li>
              <li><a href="/boonyang/list">분양 게시판</a></li>
              <li><a href="#">커넥팅 게시판</a></li>
            </ul>
          </li>
          <li><a class="nav-link scrollto" href="/faq/list">FAQ</a></li>
          <li><a class="nav-link scrollto" href="#">공지사항</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

      <a href="#appointment" class="appointment-btn scrollto"><span class="d-none d-md-inline">Make an</span> Appointment</a>

    </div>
  </header><!-- End Header -->
    </div>
  </header>
</sec:authorize>

<sec:authorize access="hasRole('ROLE_STAFF')">
  <header id="header" class="fixed-top admin-header">
    <!-- 병원관계자용 헤더 내용 -->
      <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="/">MediPaw STAFF</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="resources/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto active" href="/">Home</a></li>
          <li><a class="nav-link scrollto" href="/staff/view">계정정보</a></li>
          <li><a class="nav-link scrollto" href="#departments">동물병원 등록</a></li>
          
          <li class="dropdown"><a href="#"><span>동물병원 관리</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="/reserv/listStaff">예약 내역</a></li>
              <li><a href="/treat/listStaff">진료 내역</a></li>
              <li><a href="#">Drop Down 3</a></li>
              <li><a href="#">Drop Down 4</a></li>
            </ul>
          </li>
          <li><a class="nav-link scrollto" href="/faq/list">FAQ</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

      <a href="#appointment" class="appointment-btn scrollto"><span class="d-none d-md-inline">Make an</span> Appointment</a>

    </div>
  </header><!-- End Header -->
    <!-- 예를 들어, 다른 로고, 다른 메뉴 등을 여기에 추가 -->
  </header>
</sec:authorize>


        

        
