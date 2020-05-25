package org.nagagu.domain;

public class MessageVO {
	private int MSG_NUM;
	private int MSG_CHATROOM_NUM;
	private String MSG_CONTENT;
	private String MSG_DATE;
	
	public int getMSG_NUM() {
		return MSG_NUM;
	}
	public void setMSG_NUM(int mSG_NUM) {
		MSG_NUM = mSG_NUM;
	}
	public int getMSG_CHATROOM_NUM() {
		return MSG_CHATROOM_NUM;
	}
	public void setMSG_CHATROOM_NUM(int mSG_CHATROOM_NUM) {
		MSG_CHATROOM_NUM = mSG_CHATROOM_NUM;
	}
	public String getMSG_CONTENT() {
		return MSG_CONTENT;
	}
	public void setMSG_CONTENT(String mSG_CONTENT) {
		MSG_CONTENT = mSG_CONTENT;
	}
	public String getMSG_DATE() {
		return MSG_DATE;
	}
	public void setMSG_DATE(String mSG_DATE) {
		MSG_DATE = mSG_DATE;
	}
}
