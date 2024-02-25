<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="ozMarketTop.jsp"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/ozMarket/chatting.css" />
<!DOCTYPE html>
<html>
<head>
<title>채팅</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/ozMarket/chatting.css" />
<body>
	<h2>채팅</h2>
	<div class="chat-container">
		<div class="chat-list">
			<h3>채팅방 리스트</h3>
			<c:forEach var="room" items="${roomList}">
				<tr>
					<td><a
						href="${pageContext.request.contextPath}/ozMarket/chattRoom/${room.roomNum}">${room.roomNum}</a>
					</td>
				</tr>
			</c:forEach>
		</div>
		<div>
			<span>메세지</span>
			<!-- 메시지 표시 영역: 수신한 메시지가 여기에 출력 -->
			<div class="msgArea"></div>
		</div>
		<input type="text" placeholder="보낼 메세지를 입력하세요." class="content">
		<button type="button" value="전송" class="sendBtn" onclick="sendMsg()">전송</button>
		<button type="button" value="방나가기" class="quit" onclick="quit()">방
			나가기</button>
</body>
<script>
	var wsUrl = "ws://localhost:8080/ws/chat"; // 웹소켓 서버 URL
	var socket; // 웹소켓 객체를 전역 변수로 선언
	var sender = '${memberNickname}'; // 현재 사용자의 닉네임

	function connectWebSocket() {
		socket = new WebSocket(wsUrl);

		socket.onopen = function(e) {
			console.log('서버에 연결되었습니다!');
			enterRoom(); // 채팅방 입장 처리
		};

		socket.onclose = function(e) {
			console.log('연결이 종료되었습니다. 재연결을 시도합니다.');
			setTimeout(connectWebSocket, 5000); // 5초 후 재연결 시도
		};

		socket.onerror = function(e) {
			console.log('웹소켓 오류 발생: ', e);
		};

		socket.onmessage = function(e) {
			console.log('메시지 수신: ', e.data);
			processMessage(e.data); // 수신된 메시지 처리
		};
	}

	function enterRoom() {
		
		if (socket !== undefined && socket.readyState !== WebSocket.CLOSED) {
	        socket.close();
	    }
		// 새로운 웹소켓 연결을 초기화
	    connectWebSocket();
		
		var enterMsg = {
			"type" : "ENTER",
			"roomNum" : "${room.roomNum}",
			"sender" : sender,
			"msg" : ""
		};
		socket.onopen = function(e) {
	        console.log('서버에 연결되었습니다!');
	        socket.send(JSON.stringify(enterMsg)); // 방 입장 메시지 전송
	    };
	}

	function processMessage(message) {
		if (message === "pong") {
			console.log("하트비트 pong 수신");
			return;
		}
		let msgArea = document.querySelector('.msgArea');
		let newMsg = document.createElement('div');
		newMsg.innerText = message; // 수신된 메시지 표시
		msgArea.append(newMsg);
	}

	connectWebSocket(); // 웹소켓 연결 시도

	// 메시지 전송 버튼을 클릭했을 때 호출되는 함수
	function sendMsg() {
		let contentField = document.querySelector('.content'); // 입력 필드 선택
	    let content = contentField.value; // 입력 필드에서 메시지 내용을 가져옴

	    if (!content.trim()) {
	        console.log("메시지를 입력하세요.");
	        return; // 메시지가 비어있으면 함수를 종료
	    }
	    
		var talkMsg = {
			"type" : "TALK",
			"roomNum" : "${room.roomNum}",
			"sender" : sender,
			"msg" : content
		}; // 메시지 객체를 구성
		socket.send(JSON.stringify(talkMsg)); // 메시지를 서버에 전송
	    contentField.value = '';
	}

	// 방 나가기 버튼을 클릭했을 때 호출되는 함수
	function quit() {
		var quitMsg = {
			"type" : "QUIT",
			"roomNum" : "${room.roomNum}",
			"sender" : sender,
			"msg" : ""
		}; // 방을 나가는 메시지 객체를 구성
		if (socket.readyState === WebSocket.OPEN) {
	        socket.send(JSON.stringify(quitMsg)); // 방 나가기 메시지 전송
	    }
	    socket.close(); // 웹소켓 연결을 닫기
	    location.href = "/ozMarket/chatts"; // 사용자를 채팅 목록 페이지로 리다이렉트
	}
</script>
</html>
