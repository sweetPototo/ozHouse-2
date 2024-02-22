<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<input type="text" placeholder="보낼 메세지를 입력하세요." class="content">
<button type="button" value="전송" class="sendBtn" onclick="sendMsg()">전송</button>
<button type="button" value="방나가기" class="quit" onclick="quit()">방 나가기 </button>
<div>
    <span>메세지</span>
    <div class="msgArea"></div>
</div>
</body>

<script th:inline="javascript">
        function enterRoom(socket){
            var enterMsg={"type" : "ENTER","roomId":[[${room.roomId}]],"sender":"chee","msg":""}; //sender는  글쓸때 수정하자.
            socket.send(JSON.stringify(enterMsg));
        }
        let socket = new WebSocket("ws://localhost:8080/ws/chat");

        socket.onopen = function (e) {
            console.log('open server!')
            enterRoom(socket);
        };
        socket.onclose=function(e){
            console.log('disconnet');
        }

        socket.onerror = function (e){
            console.log(e);
        }

        //메세지 수신했을 때 이벤트.
        socket.onmessage = function (e) {
            console.log(e.data);
            let msgArea = document.querySelector('.msgArea');
            let newMsg = document.createElement('div');
            newMsg.innerText=e.data;
            msgArea.append(newMsg);
        }


        //메세지 보내기 버튼 눌렀을 떄..
        function sendMsg() {
            let content=document.querySelector('.content').value;
             var talkMsg={"type" : "TALK","roomId":[[${room.roomId}]] ,"sender":"chee","msg":content};
           socket.send(JSON.stringify(talkMsg));
        }

        function quit(){
             var quitMsg={"type" : "QUIT","roomId":[[${room.roomId}]] ,"sender":"chee","msg":""};
           socket.send(JSON.stringify(quitMsg));
            socket.close();
            location.href="/chat/chatList";
        }

</script>

</html>