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
public class TopicAction extends ActionSupport implements ModelDriven<Topic>{
	
	private Topic topic = new Topic();
	private Integer page_num;//记录当前在第几页
	
	public Integer getPage_num() {
		return page_num;
	}

	public void setPage_num(Integer pageNum) {
		page_num = pageNum;
	}

	/**
	 * 查询所有
	 * @return
	 */
	//从第几页开始查询   (page_num-1)*6
	public String findAll() {
		BusinessService businessService = new BusinessServiceImpl();
		//根据页码获取到当前页面的帖子
		List<Topic> allTopic = businessService.findTopicByState((page_num-1)*6,"审核通过");
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

	/*通过id查询主题帖【回复贴状态为“等待审核”】*/
	public String findById() {
		BusinessService businessService = new BusinessServiceImpl();
		/*获取到topic对象*/
		Topic topic = businessService.findTopicById(this.topic.getId());
		/*获取到回复列表*/
		List<Reply> replys = businessService.findReplyByState(this.topic.getId(),"审核通过");
		
		//将topic对象压入栈
		ActionContext.getContext().getValueStack().push(topic);
		//将reply对象写入action上下文
		ActionContext.getContext().put("replys", replys);
		return "findById";
	}
	
	public String deleteById() {
		BusinessService businessService = new BusinessServiceImpl();
		businessService.deleteTopicById(this.topic.getId());
		
		return "deleteById";
	}
	@Override
	public Topic getModel() {
		return this.topic;
	}
}
