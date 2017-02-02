package cn.itcast.tieba.dao;

import cn.itcast.tieba.domain.User;

public interface UserDao {

	/**
	 * 普通用户登录
	 * @param user
	 * @return
	 */
	public User findByNameAndPwd(User user);

	/**
	 * 用户注册
	 * @param user
	 * @return
	 */
	public void addUser(User user);

	/**
	 * 查询用户
	 * @param user
	 * @return
	 */
	public User findUser(User user);
}
