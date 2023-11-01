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
          <h2>⭐리뷰</h2>
        </div>
   <form name="myform" id="myform" >
     <div class="form-group row"> 
        <label class="col-sm-2" style="color:black; font-size:1.5em;">
          작성자
        </label>
        <div class="col-sm-3">
          <input type="text" name="id" id="id" class="form-control" required  style="background-color: lightgray;"
              readonly value="${rvo.id }">
        </div>
      </div>
      <div class="form-group row"> 
        <label class="col-sm-2" style="color:black; font-size:1.5em;">
          작성일자
        </label>
        <div class="col-sm-3">
          <input type="text" class="form-control" required  readonly style="background-color: lightgray;"
              readonly value=" <fmt:formatDate value="${rvo.regDate}" pattern="yyyy/MM/dd" />">
        </div>
      </div>
  <div ><span class="text-bold" style="color:black; font-size:1.5em;">별점　　　　　　　</span>
 <fieldset>
    <input type="radio" class="readonly"  name="star" value=5 id="rate1" ${rvo.star == 5 ? 'checked' : ''}><label for="rate1">★</label>
    <input type="radio" class="readonly"  name="star" value=4 id="rate2" ${rvo.star == 4 ? 'checked' : ''}><label for="rate2">★</label>
    <input type="radio" class="readonly"  name="star" value=3 id="rate3" ${rvo.star == 3 ? 'checked' : ''}><label for="rate3">★</label>
    <input type="radio" class="readonly"  name="star" value=2 id="rate4" ${rvo.star == 2 ? 'checked' : ''}><label for="rate4">★</label>
    <input type="radio" class="readonly"  name="star" value=1 id="rate5" ${rvo.star == 1 ? 'checked' : ''}><label for="rate5">★</label>
</fieldset>
</div>
      <div class="form-group row"> 
        <label class="col-sm-2"  style="color:black; font-size:1.5em;">
          리뷰제목
        </label>
        <div class="col-sm-3">
          <input type="text" name="title" id="title" class="form-control" readonly style="background-color: lightgray;" value="${rvo.title }">
        </div>
      </div>

     <div class="form-group row"> 
				<label class="col-sm-2"  style="color:black; font-size:1.5em;">
					리뷰내용 </label>
				<div class="col-sm-5">
					<textarea class="form-control" name="content"  id="content"
							  cols="50" rows="2" readonly style="background-color: lightgray;">${rvo.content }</textarea>
				</div></div>

          <hr class="my-4">
        <div class="button-container">
    <div class="form-group row mt-4">
        <div class="col text-center">
            <a class="btn btn-secondary cancelBtn" href="/review/list?animalhosp_no=${rvo.animalhosp_no }" style="width:90px;">목록으로</a>
        </div>
        <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="p"/> 
         <c:if test="${p.username eq rvo.id || p.username eq 'admin11'}">
        <div class="col text-center">
            <a class="btn btn-warning" href="/review/modify?rno=${rvo.rno}" style="width:70px;">수정</a>
        </div>
        <div class="col text-center">
            <button data-oper="remove" class="btn btn-danger" style="width:70px;" formaction="/review/remove" onclick="return delChk();" formmethod="post">삭제</button>
        </div>
    </c:if>
</sec:authorize>
	
    </div>
</div>

   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="tno"  name="tno" value="100"/>
   <input type="hidden"  id="animalhosp_no"  name="animalhosp_no" value="1"/>
     <input type="hidden"  id="rno"  name="rno" value="${rvo.rno }"/>
    </form>
    </div>

  </body>    


<script>
var result = '${result}';
if (result !== null && result !== '') {
    alert(result);
}
function delChk(){
	if(confirm('정말 삭제하시겠습니까? ')){
	}
	else {
        // "취소"를 클릭한 경우, 아무 동작도 수행하지 않고 현재 페이지에 머물기
        return false;
    }
}
function goBack() {
    history.back();
}
var ipt = document.querySelectorAll('input.readonly');
for(var i = 0; i < ipt.length; i++) {
  ipt[i].setAttribute('onclick', 'return false');
}
</script>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>