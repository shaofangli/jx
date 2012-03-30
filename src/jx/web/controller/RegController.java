package jx.web.controller;

import java.io.PrintWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jx.common.controller.JxQxMultiController;
import jx.common.db.Database;
import jx.common.listeners.AppListener;
import jx.common.tools.FinallData;
import jx.common.tools.Utils;
import jx.common.tools.sendmail.Mail;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;


public class RegController extends JxQxMultiController {
	
	private static final Log log = LogFactory.getLog(RegController.class);
	
	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("init reg.jsp...");
		return new ModelAndView(getViewName()); 
	}
	/**
	 * do reg
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 */
	public ModelAndView doReg (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("doReg...");
		
		Database db = null;
		PrintWriter out = arg1.getWriter();
		ArrayList myprm = null;
		Mail mail = null;
        try {
        	db = new Database();
        	db.initialize();
        	db.setAutoCommit(false);
        	
        	myprm = new ArrayList();
        	myprm.add(Integer.parseInt(AppListener.getPops().getProperty("wz_mrzcjs")));
        	myprm.add(Date.valueOf(arg0.getParameter("csrq")));
        	
    		db.insert(Utils.getSqlParamList('i',"jx_m_yh","zh={zh},xm={xm},mm={mm},xb={xb},yx={yx},dh={dh},mmbhwt={mmbhwt},mmbhda={mmbhda},jsdh=[0],csrq=[1]",null,null,arg0, myprm),myprm.get(0).toString());
        	
            mail = new Mail(Mail.getCommonMailMsg(arg0.getParameter("xm"),arg0.getParameter("zh"),arg0.getParameter("mm")),arg0.getParameter("yx"));
            mail.sendMessage();
        	
            String yxAdd = arg0.getParameter("yx");
            
            db.commit();
            out.write("注册已成功,请注意<a target=\"_blank\" href=\"http://mail."+yxAdd.substring(yxAdd.indexOf("@")+1,yxAdd.length())+"\">登陆邮箱</a>激活账号!");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("doReg:"+ex.getMessage());
        	if(db!=null)
        		db.rollback();
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
	/**
	 * Activation User
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 */
	public ModelAndView ActivationUsr(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("jihuo..");
		
		Database db = null;
		PrintWriter out = arg1.getWriter();
		ArrayList myprm = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	myprm = new ArrayList();
        	myprm.add(1);
        	
            db.update(Utils.getSqlParamList('u',"jx_m_yh","sfjh=[0]","zh={zh}",null,arg0, myprm),myprm.get(0).toString());
            
            arg0.getSession().setAttribute("ActivationUsr", "true");
            arg1.sendRedirect("/jx");
        } catch (Exception ex) {
        	out.write("<script>alert('fail!');</script>");
        	log.error("ActivationUsr:"+ex.getMessage());
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
	/**
	 * existUsr
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 */
	public ModelAndView existUsr(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("jiance...");
		Database db = null;
		PrintWriter out = arg1.getWriter();
		ArrayList myprm = null;
		ResultSet rs = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	myprm = new ArrayList();
        	rs = db.select(Utils.getSqlParamList('s',"jx_m_yh","zh","zh={zh}",null,arg0, myprm),myprm.get(0).toString());
            
        	if(rs.next()){
        		out.write("已存在账号"+arg0.getParameter("zh")+"!");
        	}else{
        		out.write("恭喜你,该账号可用!");
        	}
        } catch (Exception ex) {
        	out.write("服务未响应,请稍候再试!");
        	log.error("existUsr:"+ex.getMessage());
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
	
}
