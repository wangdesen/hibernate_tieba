package cn.itcast.tieba.domain;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class Reply implements Serializable{
	private Integer id;//回复编号
	private String content;//回复内容
	private String author;//作者
	private Date replyDate;//回复时间
	private String state;
	// 多个回复对应一个贴子
	private Topic topic;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public Topic getTopic() {
		return topic;
	}
	public void setTopic(Topic topic) {
		this.topic = topic;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
}
