package cn.itcast.tieba.service;

import java.util.List;

import cn.itcast.tieba.domain.Manager;
import cn.itcast.tieba.domain.Reply;
import cn.itcast.tieba.domain.Topic;
import cn.itcast.tieba.domain.User;

public interface BusinessService {

	/*【管理员】*/
	/*管理员登录*/
	public Manager manager_login(Manager manager);
	
	
	/*【普通用户】*/
	/*普通用户登录*/
	public User user_login(User user);

	/*用户注册*/
	public boolean user_add(User user);
	
	
	/*【主题帖】*/
	/*发主题帖*/
	public void saveTopic(Topic topic);
	
	/*查询所有主题帖*/
	public List<Topic> findAllTopic(Integer first_record);
	
	/*查询主题帖总条数*/
	public Integer computeAllTopic();
	
	/*根据状态查询主题帖*/
	public List<Topic> findTopicByState(Integer first_record,String topic_state);
	
	/* 通过id查询主题帖*/
	public Topic findTopicById(Integer id);
	
	/*通过id删除主题帖*/
	public void deleteTopicById(Integer id);
	
	/*更新主题帖审核状态*/
	public void updateTopicState(Topic topic);
	
	
	/*【回复贴】*/
	/*发回复帖*/
	public void saveReply(Reply reply);
	
	/*根据状态查询回复贴*/
	public List<Reply> findReplyByState(Integer topic_id,String reply_state);
	
	/*通过id查找回复贴*/
	public Reply findReplyById(Integer id);
	
	/*更新回复贴审核状态*/
	public void updateReplyState(Reply reply);
	
	/*通过id删除回复贴*/
	public void deleteReplyById(Integer id);

}
