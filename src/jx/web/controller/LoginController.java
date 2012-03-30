package jx.web.controller;

import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import jx.common.controller.JxBasicMultiController;
import jx.common.db.Database;
import jx.common.tools.FinallData;
import jx.common.tools.Utils;
import jx.web.bean.User;

public class LoginController extends JxBasicMultiController{
	
	private String initwjmm_page;
	
	private static final Log log = LogFactory.getLog(LoginController.class);
	
	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("do login...");
		
		Database db = null;
		PrintWriter out = arg1.getWriter();
		ArrayList myprm = null;
		ResultSet srs = null;
		User usr = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	myprm = new ArrayList();
        	
        	srs = db.select(Utils.getSqlParamList('s',"jx_m_yh u left join jx_m_js j on u.jsdh = j.dh",
        			"u.zh,u.xm,u.xb,u.jsdh,u.sfjh,u.grjj,u.yx,j.mc,j.mks,to_char(u.zhdl,'yyyy-mm-dd HH24:Mi:ss') zhdl","zh={zh},mm={mm}",null,arg0, myprm),myprm.get(0).toString());
            
        	myprm.clear();
            if(srs.next()){
            	if(srs.getInt("sfjh") == 1){
            		if(srs.getString("jsdh") == null){
            			out.write("非法用户!请联系网站管理员");
            		}else{
            			usr = new User();
                    	usr.setZh(srs.getString("zh"));
                    	usr.setXm(srs.getString("xm"));
                    	usr.setXb(srs.getString("xb"));
                    	usr.setJsdh(srs.getString("jsdh"));
                    	usr.setJsmc(srs.getString("mc"));
                    	usr.setZhdl(srs.getString("zhdl"));
                    	usr.setGrjj(srs.getString("grjj"));
                    	
                    	usr.setMks(srs.getString("mks"));
                    	
                    	HttpSession session = arg0.getSession();
                    	session.setAttribute(session.getId(), "logsuc");
                    	session.setAttribute("usr",usr);
                    	out.write("ok");
                    	
                    	myprm.clear();
                    	db.update(Utils.getSqlParamList('u',"jx_m_yh","zhdl=sysdate","zh={zh}",null,arg0,myprm),myprm.get(0).toString());
            		}
            	}else{
            		if(srs.getInt("sfjh") == 2)
            			out.write("账号已禁用!");
            		if(srs.getInt("sfjh") == 0){
            			String yxAdd = srs.getString("yx");
            			out.write("对不起,你的账号还未进行激活,请<a target=\"_blank\" href=\"http://mail."+yxAdd.substring(yxAdd.indexOf("@")+1,yxAdd.length())+"\">登录邮箱</a>激活账号!");
            		}
            	}
            }else{
            	out.write("用户名或密码错误!");
            }
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("view:"+ex.getMessage());
        } finally {
        	if(out != null)
        		out.close();
        	out = null;
        	if(myprm != null){
        		myprm.clear();
            	myprm = null;
        	}
            if(db != null){
            	db.terminate();
            	db = null;
            }
        }
		return null; 
	}
	
	public ModelAndView logOut (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("exit...");
		HttpSession session = arg0.getSession(false);
		session.removeAttribute("usr");
		if(arg0.getParameter("flg").equals("m")){
			return null;
		}else{
			return new ModelAndView(this.getViewName());
		}
	}
	
	public ModelAndView initWjmm (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initWjmm...");
	    return new ModelAndView(this.getInitwjmm_page());
	}
	
	public ModelAndView doRestmm (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("doRestmm...");
		Database db = null;
		PrintWriter out = arg1.getWriter();
		ArrayList myprm = null;
		int srs = 0;
        try {
        	db = new Database();
        	db.initialize();
        	
        	myprm = new ArrayList();
        	
        	srs = db.update(Utils.getSqlParamList('u',"jx_m_yh","mm={mm}","zh={zh},mmbhwt={mmbhwt},mmbhda={mmbhda}",null,arg0, myprm),myprm.get(0).toString());
            
        	myprm.clear();
            if(srs>0){
            	out.write("重设密码成功!");
            }else{
            	out.write("你提供的信息有误,请确认后重试!");
            }
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("doRestmm:"+ex.getMessage());
        } finally {
        	if(out!=null)
        		out.close();
        	out = null;
        	if(myprm != null){
        		myprm.clear();
            	myprm = null;
        	}
            if(db != null){
            	db.terminate();
            	db = null;
            }
        }
		return null; 
	}
	
	public String getInitwjmm_page() {
		return initwjmm_page;
	}

	public void setInitwjmm_page(String initwjmm_page) {
		this.initwjmm_page = initwjmm_page;
	}

}
