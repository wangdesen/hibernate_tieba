package cn.itcast.tieba.web.actions;

import cn.itcast.tieba.domain.User;
import cn.itcast.tieba.service.BusinessService;
import cn.itcast.tieba.service.impl.BusinessServiceImpl;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class UserAction extends ActionSupport implements ModelDriven<User> {

	private User user = new User();
	
	/**
	 * 用户注册
	 */
	public String add(){
		BusinessService businessService = new BusinessServiceImpl();
		boolean flag = businessService.user_add(this.user);// true:注册成功  false:注册失败
		System.out.println(flag);
		if(flag){
			return "add";
		} else{
			ActionContext.getContext().put("error", "用户名已存在");
			return "error";
		}
	}
	
	/**
	 * 用户登录
	 * @return
	 */
	public String login() {
		BusinessService businessService = new BusinessServiceImpl();
		User u = businessService.user_login(this.user);
		if(u != null) {
			//把登录对象放入session中
			ActionContext.getContext().getSession().put("user",u);//用户页面使用变量名：user
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
		ActionContext.getContext().getSession().remove("user");
		return "logout";
	}
	
	@Override
	public User getModel() {
		return this.user;
	}

}
