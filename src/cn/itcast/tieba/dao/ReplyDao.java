package cn.itcast.tieba.dao;

import java.util.List;

import cn.itcast.tieba.domain.Reply;

/**
 * 回帖
 * @author dell
 *
 */
public interface ReplyDao {

	/* 回帖*/
	public void save(Reply reply);
	
	/*通过id查找回复*/
	public Reply findById(Integer id);
	
	/*根据审核状态查询reply*/
	public List<Reply> findReplyByState(Integer topic_id,String state);
	
	/*通过id删除*/
	public void deleteById(Integer id);
	
	/*更新审核状态*/
	public void updateReplyState(Reply reply);
}
