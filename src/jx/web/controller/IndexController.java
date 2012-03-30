package jx.web.controller;

import java.sql.Clob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jx.common.controller.JxBasicMultiController;
import jx.common.db.Database;
import jx.common.listeners.AppListener;
import jx.common.models.PageInfo;
import jx.common.tools.Utils;
import jx.manage.bean.Wz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;


public class IndexController extends JxBasicMultiController {
	
	private String topbox1;
	private String topbox2;
	private String xwzxbox;
	private String jxgkbox;
	
	private static final Log log = LogFactory.getLog(IndexController.class);
	
	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("index...");
		Properties p = AppListener.getPops();
		arg0.setAttribute("wz_title",p.getProperty("wz_title").toString());
		arg0.setAttribute("wz_keywords",p.getProperty("wz_keywords").toString());
		arg0.setAttribute("wz_description",p.getProperty("wz_description").toString());
		arg0.setAttribute("wz_dbxx",p.getProperty("wz_dbxx").toString());
		arg0.setAttribute("wz_dz",p.getProperty("wz_dz").toString());
		return new ModelAndView(this.getViewName());
	}
	public ModelAndView tpbox (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("tpbox...");
		Database db = null;
		ResultSet rs = null;
		List rsList = null;
		Wz wz = null;
		Clob nrSource = null;
        String nrString = null;
        String lxsid = null;
		try {
        	db = new Database();
        	db.initialize();
        	
        	lxsid = arg0.getParameter("lxid");
        	rs = db.executeQuery(Utils.getSqlParamString('s', "jx_w_tp", "nr,alt,sx,lx", "lx="+lxsid," order by lx,sx"));
        	
        	int i = 0;
        	rsList = new ArrayList();
        	while(rs.next()){
        		 wz = new Wz();
        		 nrSource = rs.getClob("nr");
         	     nrString = nrSource.getSubString((long)1, (int)nrSource.length());
         	     
         	     wz.setBt(rs.getString("alt"));
        		 wz.setDh(rs.getString("sx"));
        		 wz.setLxmc(rs.getString("lx"));
        		 wz.setNr(proceTphtml(nrString));
        		 
        		 if(wz.getNr() != null){
        			 i++;
        			 wz.setZz(String.valueOf(i));
        			 rsList.add(wz);
        		 }
        	}
        } catch (Exception ex) {
        	log.error("tpbox:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
        }
        if("1".equals(lxsid)){
        	return new ModelAndView(this.getTopbox1(),"tps",rsList);
        }
        if("2".equals(lxsid)){
        	return new ModelAndView(this.getTopbox2(),"tps",rsList);
        }
        return null;
	}
	public ModelAndView xwzxbox (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("xwzxbox...");
		
		Database db = null;
		ResultSet rs = null;
		Wz wz = null;
        StringBuffer topdhs = new StringBuffer();
        String lxsid = null;
        String rptmp = null;
        List rsList = null;
        PageInfo pageInfo = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	lxsid = arg0.getParameter("lxid");
        	rs = db.executeQuery("select topdh from jx_w_wzlx   where  pdh ="+lxsid);
        	
        	while(rs.next()){
        		 rptmp = rs.getString("topdh");
        		 if(rptmp.length()>1)
        			 topdhs.append(rptmp.substring(1, rptmp.length()));
        	}
        	rs.close();
        	if(topdhs.length() > 2){
        		rptmp = topdhs.toString().replace('$', ',').substring(0, topdhs.length()-1);
            	
            	pageInfo = new PageInfo();
            	pageInfo.setCurrent_page(1);
            	pageInfo.setPage_sql("select w.dh,w.bt,l.lxmc,w.fbrq from jx_w_wz w inner join jx_w_wzlx l on w.lx=l.dh where w.dh in("+rptmp+") order by w.fbrq desc");
            	pageInfo.setPage_size(10);
            	db.execuPaginationSelect(pageInfo);
            	rs = pageInfo.getRs_obj();
            	rsList = new ArrayList();
            	while(rs.next()){
            		wz = new Wz();
            		wz.setBt(rs.getString("bt"));
            		wz.setDh(rs.getString("dh"));
            		wz.setLxmc(rs.getString("lxmc"));
            		//wz.setFbrq(rs.getString("fbrq").substring(0, 10));
            		
            		if(Utils.getidate(rs.getString("fbrq"))<5)
            			wz.setZz("new");
            		else
            			wz.setZz("old");
            		
            		rsList.add(wz);
            	}
        	}
        } catch (Exception ex) {
        	log.error("xwzxbox:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
            
            if(pageInfo != null)
            	pageInfo = null;
        }
        return new ModelAndView(this.getXwzxbox(),"xws",rsList);
	}
	public ModelAndView jxgkbox (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("jxgkbox..."+arg0.getParameter("lxid"));
		
		ResultSet rs = null;
        Database db = null;
        Clob nrSource = null;
        String nrString = null;
        StringBuffer rsql = new StringBuffer("select nr from jx_w_wz w , jx_w_wzlx l where l.lxmc ='"+arg0.getParameter("lxid"));
        try {
        	db = new Database();
        	db.initialize();
        	
        	rsql.append("' and w.dh = substr(l.topdh,2,(contains(substr(l.topdh,2),'$')-contains(l.topdh,'$')))");
        	rs = db.executeQuery(rsql.toString());
        	while(rs.next())
        	{
        	    nrSource = rs.getClob("nr");
        	    nrString = nrSource.getSubString((long)1, (int)nrSource.length());
        		break;
        	}
        } catch (Exception ex) {
        	//arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("jxgkbox:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
            nrSource = null;
        }
        return  new ModelAndView(this.getJxgkbox(),"jxgktpnr",nrString); 
	}
	
	
	private String proceTphtml(String nrString){
		if(nrString.indexOf("<img ") != -1){
			//System.out.println(nrString.substring(nrString.indexOf("src=")+5, nrString.indexOf(" />")-1));
			return nrString.substring(nrString.indexOf("src=")+5, nrString.indexOf(" />")-1);
		}
		return null;
	}
	public String getTopbox1() {
		return topbox1;
	}
	public void setTopbox1(String topbox1) {
		this.topbox1 = topbox1;
	}
	public String getTopbox2() {
		return topbox2;
	}
	public void setTopbox2(String topbox2) {
		this.topbox2 = topbox2;
	}
	public String getXwzxbox() {
		return xwzxbox;
	}
	public void setXwzxbox(String xwzxbox) {
		this.xwzxbox = xwzxbox;
	}
	public String getJxgkbox() {
		return jxgkbox;
	}
	public void setJxgkbox(String jxgkbox) {
		this.jxgkbox = jxgkbox;
	}
}
