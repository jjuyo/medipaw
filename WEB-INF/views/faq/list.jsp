<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style type='text/css'>
    .question {
        color: black;
        text-decoration: none;
    }
    
 	    /* Added styles for the buttons and center alignment */
    .centered {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .btn {
        border: none; 
    }
</style>

</head>
<body>
    <%@ include file="../includes/header.jsp"%>
<br><br><br><br><br><br>
<div class='container centered'>
<br>
   <div class="section-title">
          <h2>FAQ</h2>
        </div>
  <!-- Add FAQ button which triggers a modal --> 
  <sec:authorize access ="hasRole('ROLE_ADMIN')">
  
  <button type='button' class='btn ml-auto' data-toggle='modal' data-target='#addFaqModal'>등록</button> 
</sec:authorize>
</div>



<div id ='addFaqModal' class ='modal fade' tabindex ='-1' role ='dialog'> 
   <div class ='modal-dialog modal-lg'> 
      <div class ='modal-content'> 

         <!-- Modal Header --> 
         <div class ='modal-header'>  
            <h4 class ='modal-title'> FAQ 등록 </h4>  
            <button type ="button"class ="close"data-dismiss ="modal">&times; </button> 
         </div> 

         <!-- Modal Body --> 
         <div class ='modal-body'>  
            <form id='addFaqForm'> 
               <div class ='form-group'> 
                  <label for ='faqQ-input'> Question: </label>  
                  <input type ='text' class ='form-control' id='faqQ-input' name='faqQ'/> 
               </div> 

               <div class ='form-group'> 
                  <label for ='faqA-input'> Answer: </label>
                  <textarea class="form-control" name="faqA" id="faqA-input"></textarea>
               </div>

            </form> 
         </div>

         <!-- Modal Footer -->
         <div class ="modal-footer">  
            <button type ="button"class ="btn btn-secondary"data-dismiss ="modal"> Close</button>
            <!-- Add FAQ Submit Button -->
            <input type='submit' value='Submit' onclick='submitAddFaq()'class="btn"/>  
          </div>
      </div>
   </div>
</div>
 	



<div class='container'>
<c:forEach var='faqs' items='${faqs}'>
  <div class='card mt-3'>
      <div class='card-header' id='heading-${faqs.faqNo}'>
          <h2 class='mb-0 question'> <!-- Apply the custom style here -->
              <!-- Here is the button for toggling -->
     <button class='btn btn-block text-left collapsed question' type='button'
        data-toggle='collapse' data-target='#collapse-${faqs.faqNo}' aria-expanded='false'>
    F <span id ='faqQ-${faqs.faqNo}'>${faqs.faqQ}</span>
    <input type="text" class="form-control" style="display:none;" id="faqQ-input-${faqs.faqNo}" value="${faqs.faqQ}">
</button>
          </h2> 
      </div> 

      <!-- Here is the content to show/hide -->
      <div id = 'collapse-${faqs.faqNo}' class = 'collapse faq-content' aria-labelledby = 'heading-${faqs.faqNo}'> 
         <div id ='display-content-${faqs.faqNo}'class= 'card-body'> 
    A <span id ='faqA-${faqs.faqNo}'>${faqs.faqA}</span>
    <textarea class="form-control" style="display:none;" name ='faqA' id="faqA-input-${faqs.faqNo}">${faqs.faqA}</textarea>

<!-- Edit button --> 
<sec:authorize access ="hasRole('ROLE_ADMIN')">
    <button id="edit-button-${faqs.faqNo}" class='btn ml-auto' style="background-color:#F5F5DC;" onclick ="editFag(${faqs.faqNo})">Edit</button> 

    <!-- Confirm button --> 
    <input type ='submit' id="confirm-button-${faqs.faqNo}" value ='Confirm' class='btn ml-auto' style="display:none; background-color: #F5F5DC;" onclick ="submitEdit(${faqs.faqNo})"/>

    <!-- Cancel button --> 
	<button id="cancel-button-${faqs.faqNo}" style="display:none; background-color: #F5F5DC;" class='btn ml-auto' onclick='cancelEdit(${faqs.faqNo})'>Cancel</button>

<!-- Remove button --> 
    <button id="remove-button-${faqs.faqNo}" style="display:none; justify-content:flex-end; background-color: #FFE4E1;" class='btn ml-auto' onclick='removeEdit(${faqs.faqNo})'>Remove</button>
</sec:authorize>
          </div>  
    </div>  
    </div> 	 
</c:forEach>
</div>


<%@ include file="../includes/footer.jsp"%>
<script>
function editFag(faqNo) {  
    $("#faqQ-" +faqNo).hide();
    $("#faqA-" +faqNo).hide();

    $("#faqQ-input-" +faqNo).show();
    $("#faqA-input-" +faqNo).show();

   // Hide the Edit button and show the Confirm and Cancel buttons for this specific item only
   $("#edit-button-" +faqNo).hide();
   $("#confirm-button-" +faqNo).show();
   $("#cancel-button-" +faqNo).show();
   $("#remove-button-" +faqNo).show();
}

function cancelEdit(faqNo) {
	   // Show the question and answer text again
	   $("#faqQ-"+ faqNo ).show(); 
	   $("#faqA-"+ faqNo ).show(); 

	  // Hide the input fields again
	  $( "#faqQ-input-"+ faqNo ).hide(); 
	  $( "#faqA-input-"+ faqNo ).hide(); 

	  // Show the Edit button again and hide the Confirm and Cancel buttons for this specific item only
	  $( "#edit-button-"+faqNo).show();
	  $( "#confirm-button-" +faqNo).hide();
	  $( "#cancel-button-" +faqNo).hide();
	   $("#remove-button-" +faqNo).hide();


	  // Add this line to collapse the content after clicking 'Cancel'
	  $('#collapse-' + faqNo).collapse('hide');
	}
	
function submitEdit(faqNo) {
	  var csrfHeaderName = "${_csrf.headerName}";
      var csrfTokenValue = "${_csrf.token}";
    var faqQ = $("#faqQ-input-" + faqNo).val();
    var faqA = $("#faqA-input-" + faqNo).val();

    // Check if the input fields are empty
    if (faqQ === "" || faqA === "") {
        alert("입력사항을 입력해주세요.");
        return;
    }

    // Confirm the update action
    var isConfirmed = confirm("수정하시겠습니까?");
    
    if (!isConfirmed) {
        return;
    }

    // Make an AJAX request to update the data
    $.ajax({
        url: "/faq/update",  // Update this with your actual update URL
        type: "POST",
	    data: JSON.stringify({
            "faqNo": faqNo,
            "faqQ": faqQ,
            "faqA": faqA
	     }),
        
        beforeSend: function(xhr) {
	         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	     },
	    contentType: "application/json; charset=utf-8",

        success: function(response) {
            alert("수정이 완료되었습니다.");
           location.reload();   
       },
       error: function(xhr, status, error) {
           console.error(error);
           alert("An error occurred while updating the data. Please try again.");
       }
   });
}


function submitAddFaq() {
	   var csrfHeaderName = "${_csrf.headerName}";
	   var csrfTokenValue = "${_csrf.token}";
	   
	   var faqQ = $("#faqQ-input").val();
	   var faqA = $("#faqA-input").val();

	   // Check if the input fields are empty
	   if (faqQ === "" || faqA === "") {
	      alert("입력사항을 입력해주세요.");
	      return;
	   }

	   // Make an AJAX request to submit the data
	   $.ajax({
	      url: "/faq/add", // Update this with your actual add URL
	      type: "POST",
	      data: JSON.stringify({
	          "faqQ": faqQ,
	          "faqA": faqA
	       }),
	        
	       beforeSend : function(xhr) {
	           xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	       },
	       contentType : 'application/json',
	       
	       success : function(response) {
	           alert("등록이 완료되었습니다.");
	           location.reload();
	       },
	       
	       error : function(xhr, status, error) {
	           console.error(error);
	           alert("An error occurred while submitting the data. Please try again.");
	       }
	     });
	}
	
function removeEdit(faqNo) {
	   var csrfHeaderName = "${_csrf.headerName}";
	   var csrfTokenValue = "${_csrf.token}";

	   // Confirm the delete action
	   var isConfirmed = confirm("정말로 삭제하시겠습니까?");
	   
	   if (!isConfirmed) {
	       return;
	   }

	   // Make an AJAX request to delete the data
	    $.ajax({
	        url: "/faq/delete/" + faqNo,  // Update this with your actual delete URL
	        type: "POST",
	        
	        beforeSend: function(xhr) {
		         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		     },
		    
	        success: function(response) {
	            alert("삭제가 완료되었습니다.");
	           location.reload();   
	       },
	       
	       error: function(xhr, status, error) {
	           console.error(error);
	           alert("An error occurred while deleting the data. Please try again.");
	       }
	    });
	}

</script>
</body>
</html>