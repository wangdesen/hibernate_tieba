package cn.itcast.tieba.dao;

import cn.itcast.tieba.domain.Manager;

public interface ManagerDao {

	public Manager findByNameAndPwd(Manager manager);
}
