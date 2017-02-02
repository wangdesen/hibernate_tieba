package cn.itcast.tieba.service.impl;

import java.io.IOException;
import java.util.List;

import cn.itcast.tieba.dao.ManagerDao;
import cn.itcast.tieba.dao.ReplyDao;
import cn.itcast.tieba.dao.TopicDao;
import cn.itcast.tieba.dao.UserDao;
import cn.itcast.tieba.dao.impl.ManagerDaoImpl;
import cn.itcast.tieba.dao.impl.ReplyDaoImpl;
import cn.itcast.tieba.dao.impl.TopicDaoImpl;
import cn.itcast.tieba.dao.impl.UserDaoImpl;
import cn.itcast.tieba.domain.Manager;
import cn.itcast.tieba.domain.Reply;
import cn.itcast.tieba.domain.Topic;
import cn.itcast.tieba.domain.User;
import cn.itcast.tieba.service.BusinessService;

public class BusinessServiceImpl implements BusinessService {
	private TopicDao topicDao = new TopicDaoImpl();
	private ReplyDao replyDao = new ReplyDaoImpl();
	private ManagerDao managerDao = new ManagerDaoImpl();
	private UserDao userDao = new UserDaoImpl();
	
	/* 查询所有*/
	public List<Topic> findAllTopic(Integer first_record) {
		return topicDao.findAll(first_record);
	}
	
	/*根据审核状态查询*/
	public List<Topic> findTopicByState(Integer firstRecord, String topicState) {
		return topicDao.findTopicByState(firstRecord, topicState);
	}
	
	
	/*查询所有帖子条数*/
	public Integer computeAllTopic() {
		return topicDao.computeAllTopic();
	}

	/**
	 * 发贴
	 */
	public void saveTopic(Topic topic) {
		// 保存到数据库
		topicDao.save(topic);
	}

	/**
	 * 通过id查询
	 */
	public Topic findTopicById(Integer id) {
		return topicDao.findById(id);
	}
	
	/**
	 * 通过id查询回复
	 */
	public Reply findReplyById(Integer id) {
		return replyDao.findById(id);
	}

	/**
	 * 回复
	 * @throws IOException 
	 * @throws CorruptIndexException 
	 */
	public void saveReply(Reply reply) {
		// 保存到数据库
		replyDao.save(reply);
	}

	/**
	 * 通过id删除
	 */
	public void deleteTopicById(Integer id) {
		topicDao.deleteById(id);
	}

	/**
	 * 通过id删除回复
	 * @param id
	 */
	public void deleteReplyById(Integer id) {
		replyDao.deleteById(id);
	}

	/**
	 * 管理员登录
	 */
	public Manager manager_login(Manager manager) {
		return managerDao.findByNameAndPwd(manager);
	}

	/**
	 * 普通用户登录
	 */
	public User user_login(User user) {
		return userDao.findByNameAndPwd(user);
	}

	/**
	 * 用户注册
	 */
	public boolean user_add(User user) {
		User u = userDao.findUser(user);//判定用户名是否已注册
		if(u != null){
			return false;
		} else{
			userDao.addUser(user);
			return true;
		}
	}

	/*更新主题帖审核*/
	public void updateTopicState(Topic topic) {
		topicDao.updateTopicState(topic);
		
	}

	/*更新回复贴审核*/
	public void updateReplyState(Reply reply) {
		replyDao.updateReplyState(reply);
		
	}

	/*根据状态查询回复贴*/
	public List<Reply> findReplyByState(Integer topicId, String replyState) {
		System.out.println("Service层获取到topic编号："+topicId+"-----------查询状态："+replyState);
		return replyDao.findReplyByState(topicId, replyState);
	}

}
