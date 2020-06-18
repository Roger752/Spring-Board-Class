<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="./includes/header.jsp" %>

	<main>
		<div class="container-fluid">
		    <h1 class="mt-4">BBS</h1>
		    
		    <div class="card mb-4">
		        <div class="card-header"><i class="fas fa-table mr-1"></i>BBS Register Page</div>
		        <div class="card-body">
		            <div class="table-responsive">
		            	<div class="form-group">
		            		<label>Bno</label>
		            		<input class="form-control" name="bno" value="<c:out value='${board.bno}'/>" readonly>
		            	</div>
                		<div class="form-group">
                			<label>Title</label>
                			<input class="form-control" name="title" value="'${board.title }'/>" readonly>
                		</div>
                		<div class="form-group">
                			<label>Text area</label>
                			<textarea class="form-control" rows="3" name="content" readonly><c:out value="${board.content }" /></textarea>
                		</div>
                		<div class="form-group">
                			<label>Writer</label>
                			<input class="form-control" name="writer" value="<c:out value='${board.writer}'/>" readonly>
                		</div>
                		<button data-oper="modify" class="btn btn-default">Modify</button>
                		<button data-oper="list" class="btn btn-info">List</button>                	
                		
                		<form id="operForm" action="/board/modify" method="GET">
                			<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>" >
                			<input type="hidden" name="pageNum" value="${crt.pageNum}">
                			<input type="hidden" name="amount" value="${crt.amount}">
                			<input type="hidden" name="type" value="${crt.type}">
                			<input type="hidden" name="keyword" value="${crt.keyword}">
                		</form>
	                </div>
	            </div>
	        </div>
	    </div>
	</main>
	
	<script>
		$(document).ready(function() {
			var operForm = $("#operForm");

			$("button[data-oper='modify']").on("click", function(e) {
				operForm.submit();
			});
			$("button[data-oper='list']").on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list");
				operForm.submit();
			});
		});	
	</script>

<%@include file="./includes/footer.jsp" %>                