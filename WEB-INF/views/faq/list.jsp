<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Toggle Button Example</title>

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
</style>

</head>
<body>
    <%@ include file="../includes/header.jsp"%>
<br><br><br><br><br><br>
<div class='container'>
<c:forEach var='faqs' items='${faqs}'>
  <div class='card mt-3'>
      <div class='card-header' id='heading-${faqs.faqNo}'>
          <h2 class='mb-0 question'> <!-- Apply the custom style here -->
              <!-- Here is the button for toggling -->
              <button class='btn btn-link btn-block text-left collapsed question' type='button'
                      data-toggle='collapse' data-target='#collapse-${faqs.faqNo}' aria-expanded='false'>
                  F: ${faqs.faqQ}
              </button> 
          </h2> 
      </div> 

      <!-- Here is the content to show/hide -->
      <div id = 'collapse-${faqs.faqNo}' class = 'collapse faq-content' aria-labelledby = 'heading-${faqs.faqNo}'> 
          <div id ='display-content-${faqs.faqNo}'class= 'card-body'> 
              A: ${faqs.faqA}

               <!-- Edit button --> 
               <sec:authorize access ="hasRole('ROLE_ADMIN')">
                   <button onclick ="editFag(${faqs.faqNo})">Edit</button> 
               </sec:authorize>
          </div>  

           <!-- Edit Form -->
            <div id ='edit-content-${faqs.faqNo}' style = 'display: none;'> 
                <form action = '/updateFaq' method = 'post'> 
                    Question:
                    <input type = 'text' name = 'faqQ' value='${faqs.faqQ}'/>
                    
                    Answer:
                    <textarea name =' faqA'>${faqs.faqA}</textarea> 

                     <!-- Submit button --> 
                     <input type ='submit'value ='Update FAQ'/> 
                </form>
            </div>

        </div>  
    </div>   
</c:forEach>


<script> 
function editFag(id) { 
    var displayContent = document.getElementById('display-content-' + id);
    var editContent = document.getElementById('edit-content-' + id);

    if (displayContent.style.display === "none") {
        displayContent.style.display = 'block';
        editContent.style.display = 'none';
    } else {
        displayContent.style.display = 'none';
        editContent.style.display = 'block';
    }
}
</script> 

</div>
<%@ include file="../includes/footer.jsp"%>

</body>
</html>