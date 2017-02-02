package cn.itcast.tieba.dao;

import java.util.List;

import cn.itcast.tieba.domain.Topic;

/**
 * 发贴
 * @author dell
 *
 */
public interface TopicDao {
	
	/**
	 * 查询所有
	 * @return
	 */
	public List<Topic> findAll(Integer first_record);
	
	public List<Topic> findTopicByState(Integer first_record,String topic_state);
	
	public Integer computeAllTopic();
	
	/**
	 * 发贴
	 * @param topic
	 */
	public void save(Topic topic);
	
	/**
	 * 通过id查询
	 * @param id
	 * @return
	 */
	public Topic findById(Integer id);
	
	/**
	 * 通过id删除
	 * @param id
	 */
	public void deleteById(Integer id);
	
	/*更新审核状态*/
	public void updateTopicState(Topic topic);
}
