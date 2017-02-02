package cn.itcast.tieba.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import cn.itcast.tieba.util.SessionUtils;

public class SessionFilter implements Filter {

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// 获得session
		Session session = SessionUtils.getCurrentSession(); // 当前session自动关闭
		Transaction transaction = null;
		try {
			// 开启事务
			transaction = session.beginTransaction();
			// 放行
			arg2.doFilter(arg0, arg1);
			// 提交事务
			transaction.commit();
		} catch (Exception e) {
			if(transaction != null) {
				transaction.rollback();
			}
			throw new RuntimeException(e.getMessage(), e);
		} 
	}
	
	@Override
	public void destroy() {

	}
}
