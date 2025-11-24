<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>









<aside id="lnb">
	
		  
			
		   	 	<h3 class="lnb_title box_depth1_community" style="display: none;">커뮤니티</h3>  
			    <ul class="box_depth1_community" style="display: none;"> 
			    	  
			    		
					        <li class="has_sub" id="li_depth2_notice"> 
					        	
									
									
								        
								           
								        		
								            	
								            		 <a href="/ft/community/notice/nt01/list.do" target="">
								            	
								            	
								           	
								           
								        
								           
								        
									
								
					       		공지사항</a>
				       			
				       				
			            				
								            <ul>
								             	
								             		
										                <li id="li_depth3_nt01">
											                
																
																	 <a href="/ft/community/notice/nt01/list.do" target="">
																
																
															
															공지사항</a>
										                </li>
									                
								                
								             		
										                <li id="li_depth3_nt03">
											                
																
																	 <a href="/ft/community/notice/nt03/list.do" target="">
																
																
															
															공지사항3</a>
										                </li>
									                
								                
								            </ul>
								           
									
						   		
					        </li>
				        
			          
			    		
					        <li class="" id="li_depth2_qna"> 
					        	
									
										 <a href="
								/ft/community/qna/list.do
							" target="">
									
									
								
					       		Q&amp;A</a>
				       			
					        </li>
				        
			          
			    		
					        <li class="" id="li_depth2_faq"> 
					        	
									
										 <a href="/ft/community/faq/list.do" target="">
									
									
								
					       		FAQ</a>
				       			
					        </li>
				        
			          
			    		
					        <li class="" id="li_depth2_gallery"> 
					        	
									
										 <a href="/ft/community/gallery/list.do" target="">
									
									
								
					       		갤러리</a>
				       			
					        </li>
				        
			          
			    		
					        <li class="" id="li_depth2_freeboard"> 
					        	
									
										 <a href="/ft/community/freeboard/list.do" target="">
									
									
								
					       		자유게시판</a>
				       			
					        </li>
				        
			          
			    		
					        <li class="" id="li_depth2_ccccc"> 
					        	
									
										 <a href="
										
										
										
										
										
										/ft/community/ccccc/cont.do
									
									
									
									
									
									" target="">
									
									
								
					       		컨텐츠</a>
				       			
					        </li>
				        
			          
			    		
					        <li class="" id="li_depth2_survey"> 
					        	
									
										 <a href="/ft/community/survey/list.do" target="">
									
									
								
					       		설문조사</a>
				       			
					        </li>
				        
			        
			    </ul>
		   	
	      
			
	      
			
	    
    
</aside>



<script>


$(".box_depth1_"+depth1).show();
$("#li_depth2_"+depth2).addClass("on");
$("#li_depth3_"+depth3).addClass("on");


if($(".tab_uprMenuCd_"+depth4).length){
	$(".tab_uprMenuCd_"+depth4).show();
	$("#tab_box").show();
}else if($(".tab_uprMenuCd_"+depth3).length){
	$(".tab_uprMenuCd_"+depth3).show();
	$("#tab_box").show();
}else if($(".tab_uprMenuCd_"+depth2).length){
	$(".tab_uprMenuCd_"+depth2).show();
	$("#tab_box").show();
}
if($(".tab_menuCd_"+depth4).length){
	$(".tab_menuCd_"+depth4).addClass("on");
}else if($(".tab_menuCd_"+depth3).length){
	$(".tab_menuCd_"+depth3).addClass("on");
}else if($(".tab_menuCd_"+depth2).length){
	$(".tab_menuCd_"+depth3).addClass("on");
}

$(document).ready(function(){
	$(".tab_menu li a").on("click", function(){
		location.href= $(this).attr("href");
	})
}); 

</script>