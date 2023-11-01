<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<style>
#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 2em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#content {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
  .button-container {
    display: flex;
    justify-content: center;
  }

.form-control {
            width: 60%; /* Set the width to 50% of the container */
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
             justify-content: center;
             display: flex;
        }
</style>
</head>

<body>
<div class="container">
   <br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>리뷰 작성</h2>
        </div>
   <form method="post"  action="/review/write" name="myform" id="myform" >
     <div class="form-group row"> 
        <label class="col-sm-2" style="color:black; font-size:1.5em;">
          작성자
        </label>
        <div class="col-sm-3">
          <input type="text" name="id" id="id" class="form-control" required  style="background-color: lightgray;"
              readonly value="<sec:authentication property='principal.mvo.id'/>">
        </div>
      </div>
      <div class="form-group row"> 
        <label class="col-sm-2" style="color:black; font-size:1.5em;">
          작성일자
        </label>
        <div class="col-sm-3">
          <input type="text" class="form-control" required  readonly style="background-color: lightgray;"
              readonly value=" <c:set var="regDate" value="<%= new java.util.Date() %>" />
    <fmt:formatDate value="${regDate}" pattern="yy/MM/dd" />">
        </div>
      </div>
  <div ><span class="text-bold" style="color:black; font-size:1.5em;">별점　　　　　　　</span>
  <fieldset>
		<input type="radio" name="star" value=5 id="rate1" required><label
			for="rate1">★</label>
		<input type="radio" name="star" value=4 id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="star" value=3 id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="star" value=2 id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="star" value=1 id="rate5"><label
			for="rate5">★</label>
	</fieldset></div>
      <div class="form-group row"> 
        <label class="col-sm-2"  style="color:black; font-size:1.5em;">
          리뷰제목
        </label>
        <div class="col-sm-3">
          <input type="text" name="title" id="title" class="form-control" required>
        </div>
      </div>

     <div class="form-group row"> 
				<label class="col-sm-2"  style="color:black; font-size:1.5em;">
					리뷰내용 </label>
				<div class="col-sm-5">
					<textarea class="form-control" name="content"  id="content"
							  cols="50" rows="2" required ></textarea>
				</div></div>

        <hr class="my-4">
        <div class="button-container">
    <div class="form-group row mt-4">
        <div class="col text-center">
            <input type="submit" value="등록 " onclick="return tnoCheck();" class="btn btn-info regBtn">
        </div>
        <div class="col text-center">
            <button class="btn btn-secondary cancelBtn" onclick="goBack()" type="button">취소</button>
        </div>
    </div>
</div>

   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="tno"  name="tno" value="${param.tno }"/>
   <input type="hidden"  id="animalhosp_no"  name="animalhosp_no" value="${param.animalhosp_no }"/>
    </form>
    </div>
  </body>    


<script>
function goBack() {
    history.back();
}



</script>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>