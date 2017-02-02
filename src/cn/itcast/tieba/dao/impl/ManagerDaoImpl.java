package cn.itcast.tieba.dao.impl;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;

import cn.itcast.tieba.dao.ManagerDao;
import cn.itcast.tieba.domain.Manager;
import cn.itcast.tieba.util.SessionUtils;

public class ManagerDaoImpl implements ManagerDao {
	// 获得当前session
		private Session session = SessionUtils.getCurrentSession();
	/**
	 * 管理员登录
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Manager findByNameAndPwd(Manager manager) {
		List<Manager> list = session.createQuery("from Manager where username = :user and password = :pwd")
							.setString("user", manager.getUsername())
							.setString("pwd", manager.getPassword())
							.list();
		if(list.size() != 0) {
			Iterator<Manager> it = list.iterator();
			while(it.hasNext()) {
				manager = it.next();
			}
			return manager;
		} else {
			return null;
		}
	}

}
