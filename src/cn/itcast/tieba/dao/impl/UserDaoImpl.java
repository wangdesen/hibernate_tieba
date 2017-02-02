package cn.itcast.tieba.dao.impl;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;

import cn.itcast.tieba.dao.UserDao;
import cn.itcast.tieba.domain.User;
import cn.itcast.tieba.util.SessionUtils;

@SuppressWarnings("all")
public class UserDaoImpl implements UserDao {
	// 获得当前session
	private Session session = SessionUtils.getCurrentSession();
	
	/**
	 * 普通用户登录
	 */
	public User findByNameAndPwd(User user) {
		List<User> list = session.createQuery("from User where username = :username and password = :password")
							.setString("username", user.getUsername())
							.setString("password", user.getPassword())
							.list();
		if(list.size() != 0) {
			Iterator<User> it = list.iterator();
			while(it.hasNext()) {
				user = it.next();
			}
			return user;
		} else {
			return null;
		}
	}
	
	/**
	 * 用户注册
	 */
	public void addUser(User user) {
		session.save(user);
	}

	/**
	 * 查询用户
	 */
	public User findUser(User user) {
		User u = (User) session.createQuery("from User where username = :username")
							.setString("username", user.getUsername())
							.uniqueResult();
		return u;
	}
}
