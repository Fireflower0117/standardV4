<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>












	  
        <li id="li_depth1_community">
            
	        	
	        	
			        
			            <!-- 자식의 첫번째 메뉴가 손자가 없을경우 자식 URL출력 -->
			        		
			            	
			            	
			            		
						             <!-- 손자의 첫번째 메뉴가 증손이 없을경우 손자 URL출력 -->
					            		
							            	
							            		 <a href="/ft/community/notice/nt01/list.do" target="">
							            	
							            	
						            	
						            
					            
			            	
			           	
			           
			        
			           
			        
			           
			        
			           
			        
			           
			        
			           
			        
	        	
	        
            커뮤니티</a>
            
                <ul class="dp2">
            		
            			
                        	<li>	
                        		
									
									
								        
								           
								        		
								            	
								            		 <a href="/ft/community/notice/nt01/list.do" target="">
								            	
								            	
								           	
								           
								        
									
								
								공지사항</a>
                        	</li>
                        
                    
            			
                        	<li>	
                        		
									
										 <a href="
								/ft/community/qna/list.do
							" target="">
									
									
								
								Q&amp;A</a>
                        	</li>
                        
                    
            			
                        	<li>	
                        		
									
										 <a href="/ft/community/faq/list.do" target="">
									
									
								
								FAQ</a>
                        	</li>
                        
                    
            			
                        	<li>	
                        		
									
										 <a href="/ft/community/gallery/list.do" target="">
									
									
								
								갤러리</a>
                        	</li>
                        
                    
            			
                        	<li>	
                        		
									
										 <a href="/ft/community/freeboard/list.do" target="">
									
									
								
								자유게시판</a>
                        	</li>
                        
                    
            			
                        	<li>	
                        		
									
										 <a href="/ft/community/survey/list.do" target="">
									
									
								
								설문조사</a>
                        	</li>
                        
                    
                </ul>
        	
        </li>
      
        <li id="li_depth1_y2">
            
	        	 <!-- 자식메뉴가 없을경우 본인의URL 출력 -->
	        		 <a href="/ft/y2/cont.do" target=""> 
	        	
	        	
	        
            연혁</a>
            
                <ul class="dp2">
            		
            			
                    
            			
                    
            			
                    
            			
                    
            			
                    
            			
                    
                </ul>
        	
        </li>
    

<script>

$("#li_depth1_" + depth1).addClass("active_on");
</script>