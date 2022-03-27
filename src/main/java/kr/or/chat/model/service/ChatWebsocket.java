package kr.or.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.chat.model.dao.ChatDao;
import kr.or.chat.model.vo.Chat;
import kr.or.chat.model.vo.ChatBot;

public class ChatWebsocket  extends TextWebSocketHandler{
		private ArrayList<WebSocketSession> sessionList;
		private HashMap<WebSocketSession, Integer> memberList;
		@Autowired
		private ChatService service;
		@Autowired
		private ChatDao dao;
		private int adminOpenUser;  // 관리자와 대화중인 memberNo 
		private HashMap<Integer, Integer> alarmList;   // header 알림표시
		private HashMap<Integer, Integer> adminAlarm;  // adminHome 알림표시
		private int adminNo;

		public ChatWebsocket() {
			super();
			sessionList = new ArrayList<WebSocketSession>();
			memberList = new HashMap<WebSocketSession, Integer>();
			alarmList = new HashMap<Integer, Integer>();
			adminAlarm = new HashMap<Integer, Integer>();
		}

		// 웹소켓 시작
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception{
			sessionList.add(session);
			adminNo = dao.adminMemberNo("adminchat01");
		}
		
		// 웹소켓 데이터 받으면
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(message.getPayload());
			String type = element.getAsJsonObject().get("type").getAsString();
			String appendMsg = "";
			String receiveDate = "";
			String sendDate = "";
			
			// start
			if(type.equals("start")||type.equals("reStart")) {
				int memberNo = element.getAsJsonObject().get("memberNo").getAsInt();
				memberList.put(session,memberNo);
				int totalAlarm = 0;

				if(alarmList.get(memberNo)==null) {
					alarmList.put(memberNo, 0);
				}
				
				if(memberNo != adminNo) {  // 일반/전문가
					ArrayList<Chat> chatList = service.chatUserList(memberNo);
					if(chatList.size()==0) {
						appendMsg = "noListMsg";
					}else {
						for(int i=0; i<chatList.size();i++){
							int chatNo = chatList.get(i).getChatNo();
							int chatSend = chatList.get(i).getChatSend();
							int chatReceive = chatList.get(i).getChatReceive();
							String chatContent = chatList.get(i).getChatContent();
							String chatDate = chatList.get(i).getStrDate();
							if(chatReceive == memberNo){
								if(chatDate.equals(receiveDate)){
									appendMsg += "<tr><td class='receiveText'><div>"+chatContent+"</div></td></tr>";
								}else{
									appendMsg += "<tr><th class='receive'><div><img src='/resources/img/about/logo_header.png'><span>"+chatDate+"</span></div></th></tr>";
									appendMsg += "<tr><td class='receiveText'><div>"+chatContent+"</div></td></tr>";		                    			
								}
								receiveDate = chatDate;
							}else{
								if(chatDate.equals(sendDate)){
									appendMsg += "<tr><td class='sendText'><div>"+chatContent+"</div></td></tr>";
								}else{
									appendMsg += "<tr><th class='send'><div><span>"+chatDate+"</span></div></th></tr>";
									appendMsg += "<tr><td class='sendText'><div>"+chatContent+"</div></td></tr>";		                    			
								}
								sendDate = chatDate;
							}
						}
	            	}
            	}else {  // 관리자
            		if(!adminAlarm.isEmpty()) {
            			Set<Integer> keySet = adminAlarm.keySet();
    					for (Integer key : keySet) {
    						totalAlarm += adminAlarm.get(key);
    					}
    					alarmList.put(memberNo, totalAlarm);
            		}
            		ArrayList<Chat> chatList = service.chatAdminHomeList(memberNo);
            		appendMsg += "<colgroup><col style='width:80%'/><col style='width:20%'/></colgroup><tbody>";
            		for(int i=0; i<chatList.size(); i++) {
            			String chatSenderNickname = chatList.get(i).getMemberNickname();
            			String chatContent = chatList.get(i).getChatContent();
	            		String chatDate = chatList.get(i).getStrDate();
	            		int senderNo = dao.selectMemberNo(chatSenderNickname);  // 보낸사람 memberNo
	            		String adminAlarmNo = "";
	            		if(adminAlarm.get(senderNo) != null) {
	            			adminAlarmNo = adminAlarm.get(senderNo).toString();  // 보낸사람 미확인 Alarm 갯수
	            			appendMsg += "<tr class='chatHomeTr'><td class='chatId'>"+chatSenderNickname+"</td><td class='chatAdminAlarm'><span class='chatAdminAlarmSpan'>"+adminAlarmNo+"</span></td></tr>";
	            		}else {
	            			appendMsg += "<tr class='chatHomeTr'><td colspan='2' class='chatId'>"+chatSenderNickname+"</td></tr>";
	            		}
                    	appendMsg += "<tr><td class='chatText'><div>"+chatContent+"</div></td><td><span>"+chatDate+"</span></td></tr>";
            		}
                	appendMsg += "</tbody>";
				}
				JsonObject obj = new JsonObject();
				obj.addProperty("alarm", alarmList.get(memberNo));
				obj.addProperty("appendMsg", appendMsg);
				obj.addProperty("adminNo", Integer.toString(adminNo));
				session.sendMessage(new TextMessage(obj.toString()));
				
			// open chat
			}else if(type.equals("openChat")) {
				int memberNo = element.getAsJsonObject().get("memberNo").getAsInt();
				int totalAlarm = 0;
				if(memberNo == adminNo) {  // 관리자
					Set<Integer> keySet = adminAlarm.keySet();
					for (Integer key : keySet) {
						totalAlarm += adminAlarm.get(key);
					}
					alarmList.put(memberNo, totalAlarm);
				}else {  // 일반,전문가
					int alarm = element.getAsJsonObject().get("alarm").getAsInt();
					alarmList.put(memberNo, alarm);
				}
				JsonObject obj = new JsonObject();
				obj.addProperty("alarm", alarmList.get(memberNo));
				session.sendMessage(new TextMessage(obj.toString()));
				
			// close chat - admin
			}else if(type.equals("closeChat")) {
				adminOpenUser = 0;
			// chat enter
			}else if(type.equals("chat")) {
				int chatSend = element.getAsJsonObject().get("chatSend").getAsInt();
				int chatReceive = 0;
				if(chatSend == adminNo) {  // 관리자가 보내면
					String selectUser = element.getAsJsonObject().get("selectUser").getAsString();
					chatReceive = dao.selectMemberNo(selectUser);
				}else {
					//chatReceive = element.getAsJsonObject().get("chatReceive").getAsInt();
					chatReceive = adminNo;
					if(chatSend != adminOpenUser) {  // 관리자와 대화중인 유저가 아니면
						if(adminAlarm.get(chatSend) == null) {
							adminAlarm.put(chatSend, 0);
						}
					}
				}
				String chatContent = element.getAsJsonObject().get("chatContent").getAsString();
				Chat chat = new Chat();
				chat.setChatSend(chatSend);
				chat.setChatReceive(chatReceive);
				chat.setChatContent(chatContent);
				int result = service.chatSend(chat);
				if(result>0) {  // DB insert 완료
					Chat newChat = service.oneSelect(chat.getChatNo());
					Chat prevChat = service.onePrevSelect(chat.getChatSend());
					String prevDate = "";
					if(prevChat != null) {
						prevDate = prevChat.getStrDate();
					}
					for(WebSocketSession s : sessionList) {  	// 받는사람 세션정보 추출
						//int sendMemberNo = memberList.get(s);	// hash맵의 key로 value값 추출
						WebSocketSession recSocket = null;		// hash맵의 value값으로 key 추출	// 받는사람 session
						 for(WebSocketSession ws: memberList.keySet()) {
					        if(memberList.get(ws).equals(chatReceive)) {
					            recSocket = ws;
					            break;
					        }
					    }
						if(s == session){ //(chatSend == sendMemberNo) {  // 본인 화면
							appendMsg = "";
							if(newChat.getStrDate().equals(prevDate)){
								appendMsg += "<tr><td class='sendText'><div>"+newChat.getChatContent()+"</div></td></tr>";
							}else{
								appendMsg += "<tr><th class='send'><div><span>"+newChat.getStrDate()+"</span></div></th></tr>";
								appendMsg += "<tr><td class='sendText'><div>"+newChat.getChatContent()+"</div></td></tr>";		                    			
							}
							sendDate = newChat.getStrDate();
							JsonObject obj = new JsonObject();
							if(chatSend == adminNo) {
								int totalAlarm = 0;
                            	Set<Integer> keySet = adminAlarm.keySet();
                				for (Integer key : keySet) {
                					totalAlarm += adminAlarm.get(key);
                					obj.addProperty("alarm", totalAlarm);
                				}
							}else {
								obj.addProperty("alarm", alarmList.get(chatSend));
							}
							obj.addProperty("appendMsg", appendMsg);
							s.sendMessage(new TextMessage(obj.toString()));
						}else if(s!=null && recSocket!=null && s==recSocket){  // 받는사람 화면
							String receiverMsg = "";
							if(newChat.getStrDate() == receiveDate){
								receiverMsg += "<tr><td class='receiveText'><div>"+newChat.getChatContent()+"</div></td></tr>";
                    		}else{
                    			if(chatReceive==adminNo) {  // 받는사람 = 관리자
                    				if(chatSend == adminOpenUser) {
                    					receiverMsg += "<tr><th class='receive'><p class='userId'>"+newChat.getMemberNickname()+"</p><span>"+newChat.getStrDate()+"</span></th></tr>";
                    					receiverMsg += "<tr><td class='receiveText'><div>"+newChat.getChatContent()+"</div></td></tr>";
                    					adminAlarm.remove(chatSend);
                    				}else {
                    					receiverMsg = "addListMsg";
                    					int reA = adminAlarm.get(chatSend);
                						adminAlarm.put(chatSend, ++reA);
                    				}
                    			}else {  // 받는사람 = 일반,전문가
                    				receiverMsg += "<tr><th class='receive'><div><img src='/resources/img/about/logo_header.png'><span>"+newChat.getStrDate()+"</span></div></th></tr>";
                    				receiverMsg += "<tr><td class='receiveText'><div>"+newChat.getChatContent()+"</div></td></tr>";
                    			}
                    		}
                    		receiveDate = newChat.getStrDate();
                    		JsonObject obj = new JsonObject();
                    		// alarm
                    		if(chatReceive==adminNo) {
                				int totalAlarm = 0;
                            	Set<Integer> keySet = adminAlarm.keySet();
                				for (Integer key : keySet) {
                					totalAlarm += adminAlarm.get(key);
                					obj.addProperty("alarm", totalAlarm);
                				}
                    		}else {
                    			int currentAlarm = alarmList.get(chatReceive);
                    			alarmList.put(chatReceive, currentAlarm+1);
                    			obj.addProperty("alarm", alarmList.get(chatReceive));
                    		}
							obj.addProperty("appendMsg", receiverMsg);
							s.sendMessage(new TextMessage(obj.toString()));
						}
					}
				}  // result>0 end
				
			// chatbot 호출
			}else if(type.equals("chatbot")) {
				int memberNo = element.getAsJsonObject().get("memberNo").getAsInt();
				ArrayList<ChatBot> chatbot = dao.chatbotSelect();
				String chatbotMsg = "";
				chatbotMsg += "<tr><th class='receive'><div><img src='/resources/img/about/logo_header.png'><span></span></div></th></tr>";
				for(int i=0; i<chatbot.size(); i++) {
					String chatContent = chatbot.get(i).getChatContent();
					chatbotMsg += "<tr><td class='receiveText'><div>"+chatContent+"</div></td></tr>";
				}
        		receiveDate = "";
        		JsonObject obj = new JsonObject();
				obj.addProperty("alarm", alarmList.get(memberNo));
				obj.addProperty("appendMsg", chatbotMsg);
				session.sendMessage(new TextMessage(obj.toString()));
				
			// chatbotAnswer
			}else if(type.equals("chatbotAnswer")) {
				int memberNo = element.getAsJsonObject().get("memberNo").getAsInt();
				String chatKeyword = element.getAsJsonObject().get("chatContent").getAsString();
				ArrayList<String> keywordList = dao.keywordList();
				String chatbotMsg = "";
				String chatContent = "";
				int check = 0;
				for(int i=0; i<keywordList.size(); i++) {
					String keyword = keywordList.get(i);
					if(keyword.equals(chatKeyword)) {
						ChatBot chatbot = dao.chatbotOneSelect(chatKeyword);
						chatContent = chatbot.getChatContent();
						chatbotMsg += "<tr><td class='sendText'><div>"+keyword+"</div></td></tr>";
						chatbotMsg += "<tr><th class='receive'><div><img src='/resources/img/about/logo_header.png'><span></span></div></th></tr>";
						chatbotMsg += "<tr><td class='receiveText'><div>"+chatContent+"</div></td></tr>";
						check = 1;
						break;
					}
				}
				if(check == 0) {
					chatbotMsg = "noAnswer";
				}
				receiveDate = "";
				JsonObject obj = new JsonObject();
				obj.addProperty("alarm", alarmList.get(memberNo));
				obj.addProperty("appendMsg", chatbotMsg);
				session.sendMessage(new TextMessage(obj.toString()));
				
			// 관리자. 채팅방 선택
			}else if(type.equals("selectUser")) {
				String selectUser = element.getAsJsonObject().get("selectUser").getAsString();
				int sendMemberNo = dao.selectMemberNo(selectUser);
				adminOpenUser = sendMemberNo;
				adminAlarm.remove(adminOpenUser);  // 채팅창 열면 알림목록 삭제
				int sessionMemberNo = element.getAsJsonObject().get("sessionMemberNo").getAsInt();
				Chat searchChat = new Chat();
				searchChat.setChatSend(sendMemberNo);
				searchChat.setChatReceive(sessionMemberNo);
				ArrayList<Chat> chatList = service.chatAdminList(searchChat);
            	for(int i=0; i<chatList.size();i++){
            		int chatNo = chatList.get(i).getChatNo();
            		int chatReceive = chatList.get(i).getChatReceive();
            		String chatContent = chatList.get(i).getChatContent();
            		String chatDate = chatList.get(i).getStrDate();
            		String chatSenderNick = chatList.get(i).getMemberNickname();
                	if(chatReceive == sessionMemberNo){
                		if(chatDate.equals(receiveDate)){
                			appendMsg += "<tr><td class='receiveText'><div>"+chatContent+"</div></td></tr>";
                		}else{
                    		appendMsg += "<tr><th class='receive'><p class='userId'>"+chatSenderNick+"</p><span>"+chatDate+"</span></th></tr>";
	    					appendMsg += "<tr><td class='receiveText'><div>"+chatContent+"</div></td></tr>";		                    			
                		}
                		receiveDate = chatDate;
                	}else{
                		if(chatDate.equals(sendDate)){
                			appendMsg += "<tr><td class='sendText'><div>"+chatContent+"</div></td></tr>";
                		}else{
                    		appendMsg += "<tr><th class='send'><div><span>"+chatDate+"</span></div></th></tr>";
							appendMsg += "<tr><td class='sendText'><div>"+chatContent+"</div></td></tr>";		                    			
                		}
                		sendDate = chatDate;
                	}
            	}
            	int totalAlarm = 0;
            	Set<Integer> keySet = adminAlarm.keySet();
				for (Integer key : keySet) {
					totalAlarm += adminAlarm.get(key);
				}
            	JsonObject obj = new JsonObject();
				obj.addProperty("alarm", totalAlarm);
				obj.addProperty("appendMsg", appendMsg);
				session.sendMessage(new TextMessage(obj.toString()));
			}
			
			
		}
		
		// 웹소켓 종료
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
			sessionList.remove(session);
			memberList.remove(session);
			adminOpenUser = 0;
		}
		
}
