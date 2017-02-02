package cn.itcast.tieba.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class SessionUtils {
	private static SessionFactory sessionFactory = null;
	
	static{
		//默认在classpath下面寻找hibernate.cfg.xml，如果没有找到，系统打印异常
		Configuration configuration = new Configuration().configure();
		
		sessionFactory = configuration.buildSessionFactory();
	}
	
	public static Session getCurrentSession() {
		
		return sessionFactory.getCurrentSession();
	}
}
