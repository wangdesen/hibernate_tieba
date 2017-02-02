package cn.itcast.tieba.web.actions;

import cn.itcast.tieba.domain.Manager;
import cn.itcast.tieba.service.BusinessService;
import cn.itcast.tieba.service.impl.BusinessServiceImpl;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class ManagerAction extends ActionSupport implements ModelDriven<Manager> {

	private Manager manager = new Manager();
	
	/**
	 * 管理员登录
	 * @return
	 */
	public String login() {
		BusinessService businessService = new BusinessServiceImpl();
		Manager mag = businessService.manager_login(this.manager);
		
		if(mag != null) {
			ActionContext.getContext().getSession().put("manager", mag);
			return "login";
		} else {
			this.addFieldError("error", "用户名或密码错误");
			return "input";
		}
	}
	
	/**
	 * 退出
	 */
	public String logout() {
		ActionContext.getContext().getSession().remove("manager");
		return "logout";
	}
	
	@Override
	public Manager getModel() {
		return this.manager;
	}

}
