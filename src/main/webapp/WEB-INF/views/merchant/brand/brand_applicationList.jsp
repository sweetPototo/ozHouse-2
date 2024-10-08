<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 입점신청 리스트 -->
<%@ include file="../brand/brand_inform_top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>입점신청 현황</title>

<script type="text/javascript">
	function check() {
		if (window.confirm("입점신청을 취소하실시 3개월간 재신청이 불가합니다. 취소하시겠습니까?")) {
			document.f.submit();
		}
	}
</script>
<style>
body {
	background-color: #F4F4F4;
	font-family: 'Arial', sans-serif;
}

#container {
	width: 70%;
	margin: 20px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

.flex-container {
	display: flex;
	flex-direction: column;
}

.flex-row {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.flex-cell {
	flex: 1;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background: #f9f9f9;
	margin-right: 5px;
	display: flex;
	flex-direction: column;
}

.flex-cell:last-child {
	margin-right: 0;
}

.flex-cell-header {
	font-weight: bold;
	color: #333;
	margin-bottom: 5px;
}

.flex-cell-content {
	font-size: 16px;
}

.flex-row button {
	width: auto;
	padding: 10px 20px;
	background-color: #50E5B4;
	border: none;
	border-radius: 4px;
	color: white;
	cursor: pointer;
	font-size: 16px;
}

.flex-row a {
	color: #007bff;
	text-decoration: none;
}

@media ( max-width : 600px) {
	.flex-row {
		flex-direction: column;
		align-items: flex-start;
	}
	.flex-cell {
		margin-bottom: 10px;
	}
	.flex-cell:last-child {
		margin-right: 0;
	}
}
</style>
</head>
<body style="background-color: #F4F4F4">
	<div id="container">
		<h2>입점신청 현황</h2>
		<div class="center">
			<div class="flex-container">
				<div class="flex-row">
					<div class="flex-cell">
						<div class="flex-cell-header">사업자 등록번호</div>
						<div class="flex-cell-content">
							${applicationList.inComnum1}-${applicationList.inComnum2}-${applicationList.inComnum3}
						</div>
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-cell">
						<div class="flex-cell-header">상점명</div>
						<div class="flex-cell-content">
							${applicationList.inCompany}</div>
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-cell">
						<div class="flex-cell-header">홈페이지</div>
						<div class="flex-cell-content">
							${applicationList.inHomepage}</div>
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-cell">
						<div class="flex-cell-header">카테고리</div>
						<div class="flex-cell-content">
						<c:forEach var="category" items="${applicationList.inCategory}">
							${category.categoryName}/
						</c:forEach>
						</div>
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-cell">
						<div class="flex-cell-header">담당자 이름</div>
						<div class="flex-cell-content">
							${applicationList.inManname}</div>
					</div>
					<div class="flex-cell">
						<div class="flex-cell-header">담당자 전화번호</div>
						<div class="flex-cell-content">
							${applicationList.inManhp1}-${applicationList.inManhp2}-${applicationList.inManhp3}
						</div>
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-cell">
						<div class="flex-cell-header">담당자 이메일</div>
						<div class="flex-cell-content">
							${applicationList.inManemail}</div>
					</div>
				</div>
				<div class="flex-row">
				<form name = "f" method = "post" action = "/merchant/home/brand/applicationList/${applicationList.inNum}/cancel">
					<div class="flex-cell">
						<div class="flex-cell-header">첨부된 파일</div>
						<div class="flex-cell-content">
							<a href="#">${applicationList.inSaleFile} </a>
							<input type = "hidden" name = "inSaleFile" value = "${applicationList.inSaleFile}">
						</div>
					</div>
				</form>
					<div class="flex-cell">
						<div class="flex-cell-header">심사 상태</div>
						<div class="flex-cell-content">
							<c:if test="${applicationList.merIsbrand eq 't'}">
								입점 완료
							</c:if>
							<c:if test="${applicationList.merIsbrand eq 'f'}">
								승인중
							</c:if>
						</div>
					</div>
				</div>
				<c:if test="${applicationList.merIsbrand eq 'f'}">
					<div style="text-align: center;">
						<button
							style="background-color: #50E5B4; font-size: 20px; color: white; border: none; padding: 10px 10px; border-radius: 4px;"
							onclick="check()">신청취소</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
<%@ include file="../../client/main/bottom.jsp"%>