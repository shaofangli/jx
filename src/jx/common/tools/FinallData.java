package jx.common.tools;

import java.util.HashMap;
import java.util.Iterator;
import java.util.ResourceBundle;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public final class FinallData {
	public static ResourceBundle log4jconfig = ResourceBundle.getBundle("log4j");
	public static HashMap<String, String> orcl_errMap = new HashMap<String, String>();
	
	private static final Log log = LogFactory.getLog(FinallData.class);
	
	static{
		orcl_errMap.put("SYS_C006722", "账号");
		orcl_errMap.put("SYS_C006723", "邮箱");
		orcl_errMap.put("SYS_C006724", "角色代号");
		orcl_errMap.put("SYS_C006753", "图片标题");
		orcl_errMap.put("SYS_C006738", "文章标题");
		orcl_errMap.put("ORA-12899", "字符过多!");
		orcl_errMap.put("ORA-00001", "已存在!");
		orcl_errMap.put("ORA-02292","请先删除其下所属记录!");
		orcl_errMap.put("The Network Adapter could not establish the connection", "后台未开启服务!");
	}
	
	
	public static String getErrMsg(String inputStr,String nullifStr){
		String msg = null;
		try{
			if(inputStr == null || inputStr.trim().length() ==0)
				return "发生未知错误,请联系管理员!";
				
			msg = isContainsErro(inputStr);
			if(msg.trim().length()==0){
				if(nullifStr == null || nullifStr.trim().length() ==0)
					return "发生未知错误,请联系管理员!";
				else
					return nullifStr;
			}else{
				return msg;
			}
		}catch(Exception x){
			log.error("getErrMsg:"+x.getMessage());
		}
		return msg;
	}
	
	private static String isContainsErro(String inputStr){
		StringBuffer bufstr = new StringBuffer();
		try{
			Iterator it = orcl_errMap.keySet().iterator();
			while(it.hasNext()){
				String keyval = (String)it.next();
				if(inputStr.indexOf(keyval)!=-1)
				{
					bufstr.append(orcl_errMap.get(keyval)+" ");
				}
			}
		}catch(Exception x){
			log.error("isContainsErro:"+x.getMessage());
		}
		return bufstr.toString();
	}
}
