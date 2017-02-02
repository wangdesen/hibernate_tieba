package cn.itcast.tieba.web.actions;

import java.util.Date;
import java.util.List;

import cn.itcast.tieba.domain.Reply;
import cn.itcast.tieba.domain.Topic;
import cn.itcast.tieba.service.BusinessService;
import cn.itcast.tieba.service.impl.BusinessServiceImpl;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class ManagerTopicAction extends ActionSupport implements ModelDriven<Topic>{
	
	private Topic topic = new Topic();
	private Integer page_num;//记录当前在第几页
	private String topic_state;//记录主题帖审核状态
	private String reply_state;//记录回复贴审核状态
	
	public String getTopic_state() {
		return topic_state;
	}

	public void setTopic_state(String topicState) {
		topic_state = topicState;
	}

	public Integer getPage_num() {
		return page_num;
	}

	public void setPage_num(Integer pageNum) {
		page_num = pageNum;
	}
	
	public String getReply_state() {
		return reply_state;
	}

	public void setReply_state(String replyState) {
		reply_state = replyState;
	}

	/**
	 * 查询所有【只有通过审核的才能被查询到】
	 * @return
	 */
	//从第几页开始查询   (page_num-1)*6
	public String findAll() {
		BusinessService businessService = new BusinessServiceImpl();
		//根据页码获取到当前页面的帖子
		List<Topic> allTopic = businessService.findAllTopic((page_num-1)*6);
		//获取到记录条数
		Integer total_num = businessService.computeAllTopic();
		Integer total_page = 0;
		if(total_num%6==0){
			total_page = total_num/6;
		}else{
			total_page = total_num/6+1;
		}
		ActionContext.getContext().put("allTopic", allTopic);
		//total_num总共有多少条记录，从数据库获取到。total_page=total_num/6+1：表示总共有多少页
		ActionContext.getContext().getSession().put("page_num",page_num);
		ActionContext.getContext().getSession().put("total_page",total_page);//放入总页数【debug】
		return "findAll";
	}
	
	
	//根据是否通过审核进行查询
	public String findTopicByState(){
		System.out.println("进入状态查询action------");
		BusinessService businessService = new BusinessServiceImpl();
		//根据页码获取到当前页面的帖子
		List<Topic> allTopic = businessService.findTopicByState((page_num-1)*6,topic_state);
		//获取到记录条数
		Integer total_num = businessService.computeAllTopic();
		Integer total_page = 0;
		if(total_num%6==0){
			total_page = total_num/6;
		}else{
			total_page = total_num/6+1;
		}
		ActionContext.getContext().put("allTopic", allTopic);
		//total_num总共有多少条记录，从数据库获取到。total_page=total_num/6+1：表示总共有多少页
		ActionContext.getContext().getSession().put("page_num",page_num);
		ActionContext.getContext().getSession().put("total_page",total_page);//放入总页数【debug】
		return "findTopicByState";
	}
	
	
	
	/**
	 * 发贴
	 * @return
	 */
	public String add() {
		this.topic.setCreateDate(new Date());
		this.topic.setLastReplyDate(this.topic.getCreateDate());
		this.topic.setState("等待审核");
		BusinessService businessService = new BusinessServiceImpl();
		businessService.saveTopic(topic);
		
		return "add";
	}

	/*通过id查询主题帖及【状态为等待审核的回复贴】*/
	public String findById() {
		System.out.println("进入action层,主题编号："+this.topic.getId());
		BusinessService businessService = new BusinessServiceImpl();
		//根据id查找一个topic对象
		Topic topic = businessService.findTopicById(this.topic.getId());
		//查询id为topic.getId()的主题帖下状态为reply_state的回复列表
		List<Reply> replys = businessService.findReplyByState(this.topic.getId(),reply_state);
		
		//将topic压入栈
		ActionContext.getContext().getValueStack().push(topic);
		/*将replys写入action上下文*/
		ActionContext.getContext().put("replys", replys);
		return "findById";
	}
	
	/**
	 * 通过id删除
	 * @return
	 */
	public String deleteById() {
		BusinessService businessService = new BusinessServiceImpl();
		businessService.deleteTopicById(this.topic.getId());
		
		return "deleteById";
	}
	
	/*更新主题帖状态*/
	public String checkTopic(){
		BusinessService businessService = new BusinessServiceImpl();
		Topic topic = businessService.findTopicById(this.topic.getId());
		topic.setState(topic_state);
		System.out.println("新的状态："+topic_state);
		businessService.updateTopicState(topic);
		return "checkTopicState";
	}
	
	@Override
	public Topic getModel() {
		return this.topic;
	}
}
