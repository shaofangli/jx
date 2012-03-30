package jx.manage.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import jx.common.controller.JxQxMultiController;
import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.common.tools.FinallData;
import jx.common.tools.Utils;
import jx.web.bean.User;

public class GrglController extends JxQxMultiController{
	
	private String grgl_initupdatepg;
	
	private static final Log log = LogFactory.getLog(GrglController.class);
	 
	public  ModelAndView InitGrCzAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getGrgl_initupdatepg(),"pageInfo",pageInfo); 
		}
		//System.out.println("InitGrCzAction.. ");
		ResultSet rs = null;
        Database db = null;
        User usr = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	rs = db.executeQuery("select y.zh,y.mm,y.xm,y.xb,y.yx,y.dh,to_char(y.csrq,'yyyy-mm-dd') csrq,to_char(y.zcsj,'yyyy-mm-dd HH24:Mi:ss') zcsj,to_char(y.zhdl,'yyyy-mm-dd HH24:Mi:ss') zhdl,y.jsdh,y.mmbhwt,y.mmbhda,y.sfjh,y.grjj,y.bz,j.mc " +
        			"from jx_m_yh y inner join jx_m_js j on y.jsdh=j.dh where y.zh='"+arg0.getParameter("yhid")+"'");
        	
        	if(rs.next())
        	{
        		usr = new User();
        		usr.setZh(rs.getString("zh"));
        		usr.setMm(rs.getString("mm"));
        		usr.setXm(rs.getString("xm"));
        		usr.setXb(rs.getString("xb"));
        		usr.setYx(rs.getString("yx"));
        		usr.setDh(rs.getString("dh"));
        		usr.setCsrq(rs.getString("csrq"));
        		usr.setZcsj(rs.getString("zcsj"));
        		usr.setZhdl(rs.getString("zhdl"));
        		usr.setJsdh(rs.getString("jsdh"));
        		usr.setJsmc(rs.getString("mc"));
        		usr.setMmbhwt(rs.getString("mmbhwt"));
        		usr.setMmbhda(rs.getString("mmbhda"));
        		usr.setSfjh(rs.getString("sfjh"));
        		usr.setGrjj(rs.getString("grjj"));
	           	usr.setBz(rs.getString("bz"));
        	}
        	pageInfo.setAttribute_value(usr);
        } catch (Exception ex) {
        	pageInfo.setException(ex);
        	log.error("InitGrCzAction:"+ex.getMessage());
        } finally {
        	if(db!=null)
        	{
        		db.terminate();
                db = null;
        	}
        }
        return  new ModelAndView(getGrgl_initupdatepg(),"pageInfo",pageInfo); 
	}
	
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		 
		//System.out.println("updateAction.. ");
        Database db = null;
        int ups = 0;
        ArrayList myprm = null;
        try {
        	db = new Database();
        	db.initialize();
        	myprm = new ArrayList();
        	myprm.add(Date.valueOf(arg0.getParameter("csrq")));
            
        	ups = db.update(Utils.getSqlParamList('u',"jx_m_yh","jsdh={jsdh},mm={mm},xb={xb},dh={dh},mmbhwt={mmbhwt},mmbhda={mmbhda},sfjh={sfjh},bz={bz},csrq=[0]","zh={zh}",null,arg0, myprm),myprm.get(0).toString());
        	if(ups>0)
        		out.write("保存成功！");
        	else
        		out.write("不存在账号！保存失败");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("updateAction:"+ex.getMessage());
        	if(db!=null)
        		db.rollback();
        } finally {
        	if(out != null)
        		out.close();
        	out=null;
        	if(db!=null)
        	{
        		db.terminate();
                db = null;
        	}
        }
        return  null;
	}

	public String getGrgl_initupdatepg() {
		return grgl_initupdatepg;
	}

	public void setGrgl_initupdatepg(String grgl_initupdatepg) {
		this.grgl_initupdatepg = grgl_initupdatepg;
	}
}
