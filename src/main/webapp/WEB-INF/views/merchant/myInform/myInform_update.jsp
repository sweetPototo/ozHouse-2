<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../main/mainTop.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/merchant/css/update_info_style.css">
<head>
<title>OZ의 집 : 나의 정보 수정하기</title>
<script type="text/javascript">

function check(business, fileData) { 
	
	if(f.merName.value==""){
       	alert('상점 담당자의 이름을 입력해주세요.');
       	f.merName.focus();
           return;
	}
	
	var hp1 = f.merHp1.value;
	var hp2 = f.merHp2.value;
	var hp3 = f.merHp3.value;
	if(hp1=="" || hp2=="" || hp3=="") {
	alert('상점 담당자의 전화번호를 입력해주세요.');
	f.merHp1.focus();
	    return;
	}
	var hpExptext = /^[0-9]+/;
	if(hpExptext.test(hp1)==false || 
			hpExptext.test(hp2)==false || hpExptext.test(hp3)==false){
		alert("전화번호에는 숫자만 입력 가능합니다.");
		f.merHp1.focus();
		return;
	}
	
	var email = f.merEmail.value;
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

	if(exptext.test(email)==false){
	//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우	
		alert("이메일형식이 올바르지 않습니다.");
		f.merEmail.focus();
		return;
	}
	
	if(business && business.files && business.files.length > 0){
		var businessSize = business.files[0].size; 
		var businessMaxSize = 1024 * 1024 * 1024;	//1GB
	    if(businessSize > businessMaxSize) { 
	        alert("사업자등록증이 용량을 초과하였습니다. 업로드 가능한 최대크기는 1GB입니다.");
	        return;
	    }
	}
	
	if(fileData && fileData.files && fileData.files.length > 0){
	    var fileSize = fileData.files[0].size; 
	    alert("fileSize : " + fileSize);
		var maxSize = 1024 * 1024 * 1024;	//1GB
	    if(fileSize > maxSize) { 
	        alert("판매관련 첨부파일이 용량을 초과하였습니다. 업로드 가능한 최대크기는 1GB입니다.");
	        return;
	    }
	}
    document.f.submit();
	}
</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode1').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
</head>
<div class="main-notice">
	<h1>나의 정보 수정하기</h1>
	<div align="center">
		<form name="f" action="${pageContext.request.contextPath}/merchant/home/myinfo/${merchantUpdate.merNum}/modfy/ok"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="merNum" value="${merchantUpdate.merNum}">
				<div class="flex-container">
					<div class="flex-row">
						<div class="flex-header">상점명</div>
						<div class="flex-content">${merchantUpdate.merCompany}</div>
						<div class="flex-header">상점ID</div>
						<div class="flex-content">${merchantUpdate.merId}</div>
					</div>
				<div class="flex-row">
					<div class="flex-header">사업장소재지</div>
					<div class="flex-content">
						<c:set var="TextValue" value="${merchantUpdate.merAdress}"/>
						<div class="address-line">
							<span class="title">사업장 주소지</span> 
							<input type="text" id="postcode1" name="merBusinessPost" placeholder="우편번호"
								readOnly value="${merchantUpdate.merBusinessPost}" class="postcode">
							
							<button type="button" onclick="sample6_execDaumPostcode()">
								우편번호 찾기
							</button>
						</div>
						<input type="text" id="sample6_address" name="sample6_address" placeholder="주소" readOnly
							value="${fn:split(merchantUpdate.merAdress,'/')[0]}" class="full-width-input"> 
						<input type="text" id="sample6_detailAddress" name="sample6_detailAddress"
							placeholder="상세주소" value="${fn:split(merchantUpdate.merAdress,'/')[1]}"class="full-width-input"> 
						<input type="text" id="sample6_extraAddress" name="sample6_extraAddress" placeholder="참고항목" readOnly
							value="${fn:split(merchantUpdate.merAdress,'/')[2]}" class="full-width-input">
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-header">사업자등록증</div>
					<div class="flex-content">
						${merchantUpdate.merRegistration}<br> 
						<input type="file" name="merRegistration"> 
						<input type="hidden" name="old_mer_business_registration" value="${merchantUpdate.merRegistration}">
					</div>
					<div class="flex-header">사업자등록번호</div>
					<div class="flex-content">
						${merchantUpdate.merComnum1}-${merchantUpdate.merComnum2}-${merchantUpdate.merComnum3}
						<input type = "hidden" name = "merComnum1" value ="${merchantUpdate.merComnum1}">
						<input type = "hidden" name = "merComnum2" value ="${merchantUpdate.merComnum2}">
						<input type = "hidden" name = "merComnum3" value ="${merchantUpdate.merComnum3}">
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-header">상점담당자 이름</div>
					<div class="flex-content">
						<input type="text" name="merName" value="${merchantUpdate.merName}">
					</div>
					<div class="flex-header">핸드폰</div>
					<div class="flex-content phone-inputs">
						<input type="text" name="merHp1" value="${merchantUpdate.merHp1}" class="phone-number"> <span>-</span>
						<input type="text" name="merHp2" value="${merchantUpdate.merHp2}" class="phone-number"> <span>-</span>
						<input type="text" name="merHp3" value="${merchantUpdate.merHp3}" class="phone-number">
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-header">상점담장자 E-mail</div>
					<div class="flex-content">
						<input type="text" name="merEmail" value="${merchantUpdate.merEmail}">
					</div>
				</div>
				<div class="flex-row">
					<div class="flex-header">카테고리</div>
					<div class="flex-content">
						<c:if test="${empty merchantUpdate.merCategory}">
							미등록
						</c:if>
						<c:if test="${not empty merchantUpdate.merCategory}">
							<c:forEach var="cate" items="${merchantUpdate.merCategory}">
								${cate.categoryName}/
							</c:forEach>
						</c:if>
					</div>
				</div>
				<c:set var="isbrand" value="${merLoginMember.merIsbrand}"/>
				<div class="flex-row">
					<div class="flex-header">회사 홈페이지</div>
					<div class="flex-content">
					<c:if test="${merLoginMember.merIsbrand eq 'f'}">
						${merchantUpdate.merHomepage}
					</c:if>
					<c:if test="${merLoginMember.merIsbrand eq 't'}">
						<input type="text" name="inHomepage" value="${merchantUpdate.merHomepage}">
					</c:if>
					</div>
					<div class="flex-header">타입점 쇼핑몰</div>
					<div class="flex-content">
					<c:if test="${merLoginMember.merIsbrand eq 'f'}">
						${merchantUpdate.merOthershop}
					</c:if>
					<c:if test="${merLoginMember.merIsbrand eq 't'}">
						<input type="text" name="inOthershop" value="${merchantUpdate.merOthershop}">
					</c:if>
					</div>
				</div>
			</div>
			<button type="button"
				onclick="check(document.f.mer_business_registration, document.f.mer_file)">
				완료</button>
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/merchant/home/myinfo/${merchantUpdate.merNum}'">취소</button>
		</form>
	</div>
</div>
<%@ include file="../../client/main/bottom.jsp"%>