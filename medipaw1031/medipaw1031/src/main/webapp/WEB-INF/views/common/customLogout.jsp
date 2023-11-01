<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <!DOCTYPE html>
<html lang="en">

<head>
<style>
  #goLogout {
    background-color: #e74c3c; /* 빨간색 */
    color: #fff; /* 텍스트 색상을 흰색으로 설정 */
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
  }
</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                    
                       <!-- security적용할 땐 action을 무조건! /login으로 해야 함, username, Password도 무조건! -->
                        <form role="form"  action="/customLogout" method="post">
                            <fieldset>
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" value="Logout" class="btn btn-lg btn-success btn-block" id="goLogout">
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }"><!-- 서버에서 들어오는 정보 -->
                            <!-- 서버에서 _csrf의 내용을 받아오면서 침입인 건지 아닌지를 판별함 -->
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

</body>
</html>
    