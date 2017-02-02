package cn.itcast.tieba.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@SuppressWarnings("serial")
public class Topic implements Serializable{
	private Integer id;//帖子编号
	private String title;//题目
	private String author;//作者
	private Date lastReplyDate;//最后回复时间
	
	private Date createDate;//帖子创建时间
	private String state;
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	private String content;//帖子内容
	// 一个贴子对应多个回复
	private Set<Reply> replies = new HashSet<Reply>();
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getLastReplyDate() {
		return lastReplyDate;
	}
	public void setLastReplyDate(Date lastReplyDate) {
		this.lastReplyDate = lastReplyDate;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Set<Reply> getReplies() {
		return replies;
	}
	public void setReplies(Set<Reply> replies) {
		this.replies = replies;
	}
	
	
}
