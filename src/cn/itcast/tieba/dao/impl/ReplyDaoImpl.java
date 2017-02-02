package cn.itcast.tieba.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import cn.itcast.tieba.dao.ReplyDao;
import cn.itcast.tieba.domain.Reply;
import cn.itcast.tieba.util.SessionUtils;

public class ReplyDaoImpl implements ReplyDao {
	// 获得当前session
	private Session session = SessionUtils.getCurrentSession();
	
	/**
	 * 回贴
	 */
	@Override
	public void save(Reply reply) {
		session.save(reply);
	}

	/**
	 * 通过id删除
	 */
	@Override
	public void deleteById(Integer id) {
		Reply reply = (Reply) session.get(Reply.class, id);
		if(reply != null) {
			session.delete(reply);
		}
	}

	@Override
	public Reply findById(Integer id) {
		return (Reply)session.get(Reply.class,id);
	}

	@Override
	public void updateReplyState(Reply reply) {
		session.update(reply);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Reply> findReplyByState(Integer topicId, String state) {
		System.out.println("dao层-----------findReplyByState:"+state+"-----------topicId:"+topicId);
		Query q = session.createQuery("from Reply reply where reply.topic="+topicId+" and reply.state='"+state+"'");
		List l = q.list();
		return l;
	}

}
