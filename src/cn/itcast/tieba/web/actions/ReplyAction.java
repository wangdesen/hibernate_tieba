package cn.itcast.tieba.web.actions;

import java.util.Date;

import cn.itcast.tieba.domain.Reply;
import cn.itcast.tieba.domain.Topic;
import cn.itcast.tieba.service.BusinessService;
import cn.itcast.tieba.service.impl.BusinessServiceImpl;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class ReplyAction extends ActionSupport implements ModelDriven<Reply>{
	private Reply reply = new Reply();
	private String reply_state;
	public String getReply_state() {
		return reply_state;
	}

	public void setReply_state(String replyState) {
		reply_state = replyState;
	}

	/*发回复帖*/
	public String add() {
		this.reply.setReplyDate(new Date());
		this.reply.setState("等待审核");
		
		BusinessService businessService = new BusinessServiceImpl();
		
		if(reply.getTopic() != null && reply.getTopic().getId() != null) {
			Integer id = this.reply.getTopic().getId();
			Topic topic = businessService.findTopicById(id);
			topic.setLastReplyDate(new Date());
		}
		
		businessService.saveReply(reply);
		
		return "add";
	}
	
	/*管理员回复贴*/
	public String managerAdd() {
		this.reply.setReplyDate(new Date());
		this.reply.setState("等待审核");
		BusinessService businessService = new BusinessServiceImpl();
		
		if(reply.getTopic() != null && reply.getTopic().getId() != null) {
			Integer id = this.reply.getTopic().getId();
			Topic topic = businessService.findTopicById(id);
			topic.setLastReplyDate(new Date());
		}
		
		businessService.saveReply(reply);
		
		return "managerAdd";
	}
	
	/*审核回复贴*/
	public String checkReply(){
		BusinessService businessService = new BusinessServiceImpl();
		Reply reply = businessService.findReplyById(this.reply.getId());
		reply.setState(reply_state);
		System.out.println("新的状态："+reply_state);
		businessService.updateReplyState(reply);
		return "checkReplyState";
	}
	
	/*删回复贴*/
	public String deleteById() {
		BusinessService businessService = new BusinessServiceImpl();
		businessService.deleteReplyById(this.reply.getId());
		return "deleteById";
	}
	
	public Reply getModel() {
		return this.reply;
	}
}
