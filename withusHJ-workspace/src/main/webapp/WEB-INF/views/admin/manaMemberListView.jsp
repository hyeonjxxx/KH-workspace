<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin With Us</title>

<!-- Load icon library(검색) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	*{box-sizing: border-box;} 
	
	/* 여기서만 css */
	/* 내페이지 */
	.btn.btn-withus{background-color: #3498db; color: white;}
	.btn.btn-withus:hover{cursor: pointer; background-color: #2c83be;}
	
	/* search */
	.search_area {height: 60px;} 
	.search_area select{height: 36px; border-color: lightgray; outline: none;}
	
	.searchKey_1{width: 10%; position: relative; float: left;}
	.searchKey_2{width: 10%; float: left;}
	.searchKey_3{width: 50%; float: right; }
	
	.memberKeyword {width: 25%; float: left; }
	.input-group.search {width: 75%;}
	.btn.searchBtn{background-color: #3498db;}
	.fa.fa-search{color: white;}
	
	/* table */
	tbody>tr:hover{cursor: pointer;}
	table *{text-align: center; font-size: 15px;}
	table.table-bordered td, table.table-bordered th {padding: .35rem;}
	.tableHead{background-color: #eaeaea;}
	.btn-sm{ border: none;outline: none;background-color: rgb(44, 62, 80);color: white;}
	.btn-sm:hover{outline: none; border: none;}
	
	/* delModal */
	.modal-header, .modal-footer{border: none;}
	.input-group.mb-s {width: 100%; padding: 0 50px;}
	button.btn.btn-secondary{ width: 47%; float: left;}
	button.btn.btn-withus{ width: 47%;}
	.modal-footer{height: 80%;}
	
	/* pagination */
	.paging_wrap{width:fit-content;margin:auto; margin-top: 50px;}
	.pagination a {
	    color: black;
	    float: left;
	    padding: 8px 16px;
	    text-decoration: none;
	    transition: background-color .3s;
	}
</style>
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../common/manaHeader.jsp"/>
	
	<div class="content_wrap">
	    <div class="title" align="left">
	        <label>회원 조회</label>
	    </div>
	    <div class="container">
	
	        <div class="search_area">
	        	<form action="searchMember.mana" name="searchForm" method="post">
	        	<input type="hidden" name="currentPage" value="1">
	             <div class="searchKey_1">
	                 <select name="partnerJoin" id="partnerJoin">
	                     <option value="memberAll">전체</option>
	                     <option value="supporter">서포터</option>
	                     <option value="partner">파트너</option>
	                 </select>
	             </div>
	             <div class="searchKey_2">
	                <select name="memberStatus" id="memberStatus">
	                    <option value="T"> 전체</option>
	                    <option value="Y">활동</option>
	                    <option value="N">탈퇴</option>
	                    <option value="A">관리자</option>
	                </select>
	            </div>
	
	            <div class="searchKey_3">
	                <div class="memberKeyword">
	                    <select name="memberInfo" id="memberInfo">
	                        <option value="all">전체</option>
	                        <option value="memberNo">회원번호</option>
	                        <option value="memberName">이름</option>
	                        <option value="email">이메일</option>
	                    </select>
	                </div>
	
	                <div class="input-group search">
	                    <input type="text" name="memKeyword" value="${ keyword }" class="form-control" placeholder="검색어를 입력하세요">
	                    <div class="input-group-append">
	                        <button class="btn searchBtn" type="submit"><i class="fa fa-search"></i></button>
	                    </div>
	                </div>
	            </div>
				</form>
	        </div>
	        <c:if test="${ !empty partnerJoin }">
	        	<script>
	        	$(function(){
	        		$(".partnerJoin option[value=${partnerJoin}]").attr("selected", true);
	        	});
	        	</script>
	        </c:if>
	        <c:if test="${ !empty memberStatus }">
	        	<script>
	        	$(function(){
	        		$(".memberStatus option[value=${memberStatus}]").attr("selected", true);
	        	});
	        	</script>
	        </c:if>
	        <c:if test="${ !empty memberInfo }">
	        	<script>
	        	$(function(){
	        		$(".memberInfo option[value=${memberInfo}]").attr("selected", true);
	        	});
	        	</script>
	        </c:if>
	
			<!-- 회원리스트 영역 -->
	        <table class="table table-bordered">
	            <thead class="tableHead">
	                <tr>
	                    <th>회원번호</th>
	                    <th>이메일</th>
	                    <th>이름</th>
	                    <th>가입일</th>
	                    <th>파트너 유무</th>
	                    <th width="200">파트너명</th>
	                    <th>상태</th>
	                    <th>관리</th>
	                </tr>
	            </thead>
	            <tbody>
	            	<c:forEach var="m" items="${ mList }">
		                <tr>
		            	  	<input type="hidden" id="mno" name="mno" value="${m.memberNo}">
		                    <td>${ m.memberNo }</td>
		                    <td>${ m.memberId }</td>
		                    <td>${ m.memberName }</td>
		                    <td>${ m.memberCreateDate }</td>
		                    <td>${ m.partnerJoin }</td>
		                    <td>
		                    	<c:choose>
		                    	<c:when test="${!empty m.partnerName }">
		                    		${ m.partnerName }
		                    	</c:when>
		                    	<c:otherwise>
		                    		-
		                    	</c:otherwise>
		                    	</c:choose>
		                    </td>
		                    <td>${ m.memberStatus }</td>
		                    <td><button type="button" id="delMem" class="btn-sm" data-toggle="modal" data-target="#delModal">
		                    	탈퇴</button></td>
		                </tr>
	                </c:forEach>            
	            </tbody>
	        </table>
	        <script>
	        	// 탈퇴 모달
	        	
	        	$(function(){
	        		$("#delMem").click(function(){
	        			var $memberNo = $("#mno").eq(0).val();
	        			console.log($memberNo);
	        			
	        			$.ajax({
		        			url:"memStatus.mana",
		        			data:{mno:$memberNo},
		        			success:function(ms){
		        				console.log(ms);
		        				var result = "<div>" 
		        							+ ms.memberName 
		        							+ " 회원을 탈퇴시키겠습니까?</div>"
		        							+ "<input type=" 
		        							+ "hidden value="
		        							+ ms.MemberNo
		        							+ " name="
		        							+ "memberNo"+
		        							">"
		        				

		        				$(".modal-title").html(result);
		        				
		        			}, error: function(){
		        				console.log("모달 조회 실패")
		        			}
		        		});
	        			
	        		});
	        	});
	        	
	        	
	        </script>
	        
	    </div>
	
				 <!-- 탈퇴 클릭 시 모달  -->
			    <!-- The Modal -->
			    <div class="modal fade" id="delModal">
			        <div class="modal-dialog modal-dialog-centered" style="width: 380px;">
			        <div class="modal-content">
			        	
	            		<form id="delectMem" action="deleteMem.mana" method="post">
			            <!-- Modal Header -->
			            <div class="modal-header">
			            <h5 class="modal-title"> </h5>
			            
			            <button type="button" class="close" data-dismiss="modal">&times;</button>
			            </div>
			            
			            <!-- Modal body -->
			            <div class="modal-body">
		            		
		                     <div class="input-group mb-s" >
		                        <div class="input-group-prepend">
		                          <span class="input-group-text">회원상태</span>
		                        </div>
		                        
		                        <select class="form-control" id="memberStatus" name="memberStatus">
		                          <option value="Y">활동</option>
		                          <option value="N">탈퇴</option>
		                        </select>
		                        
		                        <!-- 수정된 회원상태 컨트롤러에 넘겨주는 함수 -->
		                        <script>
		                        	$(function(){
		                        		$("#memberStatus option").each(function(){
		                        				$(this).attr("selected", true);
		                        			});
		                        		});
		                        </script> 
		                         
		                    	</div>
			            	</div>
			            
				            <!-- Modal footer -->
				            <div class="modal-footer">
				            	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				            	<button type="submit" class="btn btn-withus" data-dismiss="modal">확인</button>
				            </div>
            			</form>
			             
			        </div>
			        </div>
			    </div>	
			    			            
		             
	
	    
	    <br clear="both"><br>
	
	    <!-- 페이징 -->
	    <div class="paging_wrap">
	        <ul class="pagination">
	        	<c:choose>
	        		<c:when test="${ pi.currentPage eq 1 }">
		           		<li class="page-item"><a class="page-link" href="#">이전</a></li>
		            </c:when>
		            <c:otherwise>
		            	<li class="page-item disabled"><a class="page-link" href="${ pi.currentPage -1 }">이전</a></li>
		            </c:otherwise>
		    	</c:choose>        
		            
				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	            	<li class="page-item"><a class="page-link" href="memberListView.mana?currentPage=${p}">${ p }</a></li>
				</c:forEach>		            
		            
		        <c:choose> 
		        	<c:when test="${ pi.currentPage eq pi.maxPage }">
		           	 	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
		           	</c:when>
		           	<c:otherwise>
		           		<li class="page-item"><a class="page-link" href="${ pi.currentPage+1 }">다음</a></li>
		           	</c:otherwise> 	
	        	</c:choose>
	        </ul>
	    </div>
	
	</div>

</body>
</html>