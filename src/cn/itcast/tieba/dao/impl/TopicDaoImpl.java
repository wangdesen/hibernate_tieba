package cn.itcast.tieba.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import cn.itcast.tieba.dao.TopicDao;
import cn.itcast.tieba.domain.Topic;
import cn.itcast.tieba.util.SessionUtils;

public class TopicDaoImpl implements TopicDao {
	// 获得当前session
	private Session session = SessionUtils.getCurrentSession();
	
	/**
	 * 查询所有
	 * @see cn.itcast.tieba.dao.TopicDao#findAll()
	 */
	@SuppressWarnings("unchecked")
	@Override
	//hibernate查询：session.createQuery();
	//hibernate插入：session.save();
	//通过id查询：session.get(Topic.class,id);
	//hibernate删除：session.delete();//对象
	public List<Topic> findAll(Integer first_record) {
		//从数据库中取出数据
		Query q = session.createQuery("from Topic topic order by topic.lastReplyDate desc");
		q.setFirstResult(first_record);//
		q.setMaxResults(6);
		List l = q.list();
		//return session.createQuery("from Topic").list();
		return l;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Topic> findTopicByState(Integer first_record,String topic_state) {
		//从数据库中取出数据
		Query q = session.createQuery("from Topic topic where topic.state='"+topic_state+"'order by topic.lastReplyDate desc");
		System.out.println("Dao层中state状态是："+topic_state);
		q.setFirstResult(first_record);//
		q.setMaxResults(6);
		List ll = q.list();
		//return session.createQuery("from Topic").list();
		return ll;
	}
	
	/*查询所有帖子条数*/
	/*这边又费了好大的劲*/
	@Override
	public Integer computeAllTopic() {
		long count = (Long)session.createQuery("select count(*) from Topic").uniqueResult();
		Integer res= new Integer(String.valueOf(count));
		return res;
	}

	/**
	 * 发贴
	 */
	@Override
	public void save(Topic topic) {
		session.save(topic);
	}

	/**
	 * 通过id查询
	 */
	@Override
	public Topic findById(Integer id) {
		
		//List results = session.createSQLQuery("select * from t_topic t where t.id = "+id).addEntity(Topic.class).list();
		//Topic tt = (Topic)results.get(0);
		//return tt;
		
		return (Topic)session.get(Topic.class,id);
	}

	/**
	 * 通过id删除
	 */
	@Override
	public void deleteById(Integer id) {
		Topic topic = (Topic) session.get(Topic.class, id);
		// 级联删除多个对象时需要判断对象是否为null
		if(topic != null) {
			session.delete(topic);
		}
	}

	@Override
	public void updateTopicState(Topic topic) {
		System.out.println("Dao层："+topic.getState());
		session.update(topic);
		
	}

}
