$(document).ready(function() {
    function loadHospitalData(pageNum) {
        $.ajax({
            url: "/animalhosp/list",
            method: "GET",
            dataType: 'json', 
            data: { 
                pageNum: pageNum,
                amount: 10
            },
            success:function(response){
                console.log(response);
                
                 var hospitals = response.hospitals; 
                 var pageMaker = response.pageMaker;
                 var start = pageMaker.start;
                 var end = pageMaker.end;
                 var prev = pageMaker.prev;
                 var next = pageMaker.next;

                 $("#hospitalTable tbody").empty();
                 
                 for(var i=0;i<hospitals.length;i++){
                     let tr=document.createElement('tr');                       
                             tr.innerHTML="<td>"+hospitals[i]['animalhosp_no']+"</td>"+
                                          "<td>"+hospitals[i]['animalhosp_name']+"</td>"+
                                          "<td>"+hospitals[i]['a_latitude']+"</td>"+
                                          "<td>"+hospitals[i]['a_hardness']+"</td>";
                             $("#hospitalTable tbody").append(tr);
                  }              
                 
                  $("#pagination").empty();
                  if (prev) {
                      $("#pagination").append('<li class="page-item"><a href="#" class="page-link" data-page="' + (start - 1) + '">&laquo; Previous</a></li>');
                  }              
                  
                  for (var i=start; i<=end; i++) {
                      let activeClass=i===pageNum?'active':'';
                      $("#pagination").append('<li class="page-item '+activeClass+'"><a href="#" class="page-link" data-page="' +i+'">'+i+'</a></li>');
                   }
                   
                   if(next){
                       $("#pagination").append('<li class="page-item"><a href="#" the="page-link" data-page="' +(end+1)+'">Next &raquo;</a></li>');
                   }
             },
             error:function(xhr,status,error){
               console.error(error);
             }
         });
     }

     loadHospitalData(1); // 페이지 로드 시 첫 번째 페이지 데이터 불러오기

     $(document).on('click', '#pagination a', function(e) {
         e.preventDefault();
         var pageNum = $(this).data('page');
         loadHospitalData(pageNum);
     });
});