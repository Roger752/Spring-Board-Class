<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="./includes/header.jsp" %>
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">BBS</h1>
                        
                        <div class="card mb-4">
                            <div class="card-header"><i class="fas fa-table mr-1"></i>BBS List Page
                            	<button id="regBtn" type="button" class="btn btn-xs float-right">Register New Board</button>
                            
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                <!-- id dataTable 자동으로 참조하여 페이지네이션 -->
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>#번호</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                                <th>수정일</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>#번호</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                                <th>수정일</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        	<c:forEach items="${list}" var="board">
                                        		<tr>
                                        			<td><c:out value="${board.bno}" /></td>
                                        			<td><a class="move" href="<c:out value='${board.bno}'/>"><c:out value="${board.title}" /></a></td>
                                        			<td><c:out value="${board.writer}" /></td>
                                        			<td><fmt:formatDate pattern="yyyy-MM-dd"
                                        					value="${board.regdate}" /></td>
                                        			<td><fmt:formatDate pattern="yyyy-MM-dd"
                                        					value="${board.updatedate}" /></td>
                                        		</tr>
                                        	</c:forEach>
                                        </tbody>
                                    </table>
                                    
                                    <div class="row">
                                    	<div class="col-lg-12">
                                    		<form id="searchForm" action="/board/list" method="get">
                                    			<select name="type">
                                    				<option value="" <c:out value="${pageMaker.crt.type == null ? 'selected' : ''}"/>>------</option>
                                    				<option value="T" <c:out value="${pageMaker.crt.type eq 'T' ? 'selected' : ''}"/>>제목</option>
                                    				<option value="C" <c:out value="${pageMaker.crt.type eq 'C' ? 'selected' : ''}"/>>내용</option>
                                   					<option value="W" <c:out value="${pageMaker.crt.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
                                   					<option value="TC" <c:out value="${pageMaker.crt.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
                                   					<option value="TW" <c:out value="${pageMaker.crt.type eq 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
                                   					<option value="WC" <c:out value="${pageMaker.crt.type eq 'WC' ? 'selected' : ''}"/>>작성자 or 내용</option>
                                   					<option value="TWC" <c:out value="${pageMaker.crt.type eq 'TWC' ? 'selected' : ''}"/>>제목 or 작성자 or 내용</option>
                                    			</select>
                                    			<input type="text" name="keyword" value="${pageMaker.crt.keyword}">
                                    			<input type="hidden" name="pageNum" value="${pageMaker.crt.pageNum}">
                                    			<input type="hidden" name="amount" value="${pageMaker.crt.amount}">
                                    			<button class="btn btn-default">Search</button>
                                    		</form> 
                                    	</div>
                                    </div>
                                    
                                    <div class="float-right">
									  <ul class="pagination">
									    <li class="page-item ${pageMaker.prev == true ? '' : 'disabled' }">
									      <a class="page-link" href="${pageMaker.startPage-1}" tabindex="-1">Previous</a>
									    </li>
									    
									    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
									    	<li class="page-item ${pageMaker.crt.pageNum==num ? 'active' : ''}"><a class="page-link" href="${num}">${num}</a></li>
									    </c:forEach>
									    
									    <li class="page-item ${pageMaker.next == true ? '' : 'disabled' }">
									      <a class="page-link" href="${pageMaker.endPage+1}">Next</a>
									    </li>
									  </ul>
									</div>
									
									<form id="actionForm" action="/board/list" method="get">
										<input type="hidden" name="pageNum" value="${pageMaker.crt.pageNum}">
										<input type="hidden" name="amount" value="${pageMaker.crt.amount}">
										<input type="hidden" name="type" value="${pageMaker.crt.type}">
										<input type="hidden" name="keyword" value="${pageMaker.crt.keyword}">
									</form>
                                    
                                    <div class="modal" id="myModal" tabindex="-1" role="dialog">
									  <div class="modal-dialog" role="document">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title">Modal title</h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
									        <p>Modal body text goes here.</p>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-primary">Save changes</button>
									        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
									      </div>
									    </div>
									  </div>
									</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                
                <script>
					$(document).ready(function() {
						var result = '<c:out value="${result}"/>';
						
						checkModal(result);

						history.replaceState({}, null, null);

						function checkModal(result) {
							if (result == '' || history.state)
								return;

							if (parseInt(result) > 0) {
								$(".modal-body").html("게시글 " + result + "번이 등록되었습니다.");
							} else {
								$(".modal-body").html(result);
							}
							$("#myModal").modal("show");
						}	

						$("#regBtn").on("click", function() {
							self.location = "/board/register";		
						});

						var actionForm = $("#actionForm");
						var searchForm = $("#searchForm");

						var actionForm = $("#actionForm");
						$(".page-item a").on("click", function(e) {
							e.preventDefault();
							console.log("click");
							actionForm.find("input[name='pageNum']").val($(this).attr("href"));
							actionForm.find("input[name='type']").val(searchForm.find("option:selected").val());
							actionForm.find("input[name='keyword']").val(searchForm.find("input[name='keyword']").val());
							actionForm.submit();
						});

						$(".move").on("click", function(e) {
							e.preventDefault();
							actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>'");
							actionForm.attr("action", "/board/get");
							actionForm.submit();
						});

						var searchForm = $("#searchForm");

						$("#searchForm button").on("click", function(e) {
							if(!searchForm.find("option:selected").val()) {
								alert("검색조건을 선택하세요");
								return false;
							}

							if(!searchForm.find("input[name='keyword']").val()) {
								alert("키워드를 입력하세요");
								return false;
							}

							searchForm.find("input[name='pageNum']").val("1");

							searchForm.submit();
						});
						
					});
                </script>
<%@include file="./includes/footer.jsp" %>                
                