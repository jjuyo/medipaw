<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>login</title>
     <style>
  select {
            border: 1px solid #ccc;
            padding: 5px;
            font-size: 10px;
            border-radius: 5px;
        }

        body {
            background-color: #87CEFA;
            font-family: 'Gaegu', cursive;
        }

        .login-panel {
            position: relative;
            margin: 50px auto;
            max-width: 300px;
        }

        #title-line {
            border-top: 2px solid #87CEFA;
            position: relative;
            margin: 50px 0;
        }

        #signup-box {
            width: 200px;
            height: 50px;
            background-color: #87CEFA;
            color: white;
            position: absolute;
            top: -25px;
            left: calc(50% - 100px);
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 10%;
        }

        .container {
            max-width: 960px;
        }

        .form-control {
            border-radius: 50px;
        }

        .btn {
            border-radius: 50px;
        }

        .form-horizontal {
            padding: 20px;
            background: white;
            border-radius: 30px;
            box-shadow: 0px 0px 10px gray;
        }

        input[type="text"],
        input[type="password"],
        input[type="tel"],
        input[type="date"] {
            border-radius: 30px !important;
        }

        select {
            border-radius: 30px !important;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background: url('http://www.familylovedproducts.com/wp-content/uploads/2018/02/white-arrow-204-2048179.png') no-repeat scroll right center transparent;
            padding-right: 25px;
        }

        ::placeholder {
            color: #BDBDBD !important;
            opacity: 1 !important;
        }

        div {
            margin-bottom: 10px;
            padding: 1px;
        }

        .divC {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* The Modal (background) */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
        }

        /* Modal Content (box) */
       /* 모달 스타일 수정 */
  .modal-content {
    background-color: white;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    border-radius: 10px;
    width: 40%; /* 모달의 너비를 60%로 설정, 화면 크기에 따라 조정 가능 */
    max-width: 500px; /* 최대 너비를 지정하여 너무 커지지 않도록 함 */
    height: auto; /* 내용에 맞게 높이를 자동으로 조정 */
  }
    </style>


</head>

<body>
	<%@ include file="../includes/header.jsp"%>
<br><br>
<br>
<br>
<br>
<br>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">LOGIN</h3>
                    </div>
                    <div class="panel-body">
                    <!-- 에러 메시지 표시 -->
                    <h6 style="color:red">${error }</h6>
                    <h6 style="color:red">${logout }</h6>
                    <!-- END 에러 메시지 표시 -->
                    
                       <!-- security적용할 땐 action을 무조건! /login으로 해야 함, username, Password도 무조건! -->
                        <form role="form"  action="/login" method="post"><!-- 비밀번호 노출되면 안되니까 꼭 post -->
                            <fieldset>
                                   <div class="form-group">
                                    <input class="form-control" placeholder="ID" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                </div>
                                <h6 id="error"></h6>
                                
                                <div class="checkbox">
                                
                                    <label>
                                        <input name="remember-me" type="checkbox" >Remember Me
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <div style="display: flex; justify-content: space-between;">
    <input type="submit" value="login" class="fas fa-sign-in-alt">
    <input type ="button" id="findIdBtn" class="fas fa-user" value="Find ID">
    <input type="button" id="findPasswordBtn" class="fas fa-key" value="Forgot PW">
</div>
</fieldset>
                            <input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }"><!-- 서버에서 들어오는 정보 -->
                            <!-- 서버에서 _csrf의 내용을 받아오면서 침입인 건지 아닌지를 판별함 -->
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- ID Recovery Modal -->
<div id="idRecoveryModal" class="modal">
  <div class="modal-content" style="width: 30%; margin: 100px auto;">
    <span class="close" style="position: absolute; top: 10px; right: 10px; font-size: 24px;">&times;</span>
    FIND ID
    <form id="idRecoveryForm" style="padding: 20px;">
        <div style="margin-bottom: 10px;">
            <input type="text" placeholder="NAME" name="name" id="name" required>
        </div>
        <div style="margin-bottom: 10px;">
            <input type="text" placeholder="PHONE" pattern="\d{11}" name="phone" id="phone" placeholder="01012345678" required>
        </div>
        <br>
        <input type="button" value="Find ID" id="findBtn" onclick="findId()">
    </form>
    <!-- Display the result here -->
    <p id="result" style="text-align: center;"></p>
    <!-- Confirm button -->
    <input type="button" value="OK" onclick="confirmId()" style="width: 100%; display: none;" id="confirmButton">
</div>
</div>

<!-- Link to open the modal -->

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>

$(document).ready(function() {
    //on login button click
    $('input[type=submit][value=login]').click(function(e) {

        //Prevent the form from submitting (default action)
        e.preventDefault();

        var usernameFieldEmpty = !$('input[name=username]').val();
        var passwordFieldEmpty = !$('input[name=password]').val();

         if(usernameFieldEmpty || passwordFieldEmpty) { 
            // If any field is empty, display an error message and stop here
            $('#error').text('Please fill in all fields.').css('color', 'red');
            return;
         }

         this.form.submit();  // If both fields are filled, submit the form

      });
});

$(document).ready(function() {
    
     //on form submit
     $('#findBtn').click(function(e) {

        //Prevent the form from submitting (default action)
        e.preventDefault();

         //validate fields and show error messages if empty or invalid
         var nameFieldEmpty = !$('#name').val();
         var emailFieldEmptyOrInvalid = !$('#email').val() || !/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i.test($('#email').val());

         $('#errorName').toggle(nameFieldEmpty);
         $('#errorEmail').toggle(emailFieldEmptyOrInvalid);

          if (!nameFieldEmpty && !emailFieldEmptyOrInvalid) { // If both fields are valid, submit the form
            this.submit();
          } 

      });
});

// Open the modal
$('#findIdBtn').click(function(event){
  var modal = document.getElementById('idRecoveryModal');
  modal.style.display = "block";
});

// Close the modal
var span = document.getElementsByClassName("close")[0];
span.onclick = function() {
  var modals = document.getElementsByClassName("modal");
  for (var i = 0; i < modals.length; i++) {
    modals[i].style.display = "none";
  }
};

// Send AJAX request to find ID
function findId() {
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    var name = $('#name').val();
    var phone = $('#phone').val();

    $.ajax({
        url: '/member/findId',
        dataType : 'text',
        method: 'POST',
        data: { "name" : name, "phone": phone },
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function(data) {
                $('#result').css('color', 'black').text("아이디는 : " + data + " 입니다.");
                $('#confirmButton').show();
        },
        error:function(request,status,error){
            $('#result').css('color', 'red').text("ID가 존재하지 않습니다.");
            $('#confirmButton').hide();
        }
      });
}
//Confirm the found ID and close the modal
function confirmId() {
	var modals = document.getElementsByClassName("modal");
	for (var i = 0; i < modals.length; i++) {
		modals[i].style.display = "none";
	}
	var foundIdText = $("#result").text();
	var foundId = foundIdText.substring(foundIdText.indexOf(':') + 2, foundIdText.indexOf(' 입니다.'));
	if(foundId) { // if an ID was found
		$("input[name=username]").val(foundId); // fill in the login form with it
	}
}

$('#findPasswordBtn').click(function(){
	   window.location.href='/member/findpsw';
});
</script>



<%@ include file="../includes/footer.jsp"%>

</body>

</html>