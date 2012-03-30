package jx.common.models;

import java.sql.ResultSet;
import java.util.ArrayList;
import jx.common.exceptions.MyException;
import jx.common.listeners.AppListener;

public class PageInfo {
	
	//有默认参数文件
	//private static ResourceBundle config = ResourceBundle.getBundle("log4j");
    
	private int all_pagecount; //总页数
	private int all_rowscount; //总记录数
	private int current_rowscount;//当前请求页的记录数
	private int current_page = 1;//当前第几页
	private int page_size = 25;//每页显示记录数,默认为25
	private boolean isSetps = false;//是否手动设置页显示数
	
	private String page_sql;//页面的查询sql;
	private ResultSet rs_obj;//查询结果集;
	private ArrayList attribute_param;//属性中设置的返回值(list);
	private Object attribute_value;//属性中设置的返回值(非list);
	
	private MyException exception = null;
	
	public int getAll_pagecount() {
		return all_pagecount;
	}
	public void setAll_pagecount(int all_pagecount) {
		this.all_pagecount = all_pagecount;
	}
	public int getAll_rowscount() {
		return all_rowscount;
	}
	public void setAll_rowscount(int all_rowscount) {
		this.all_rowscount = all_rowscount;
	}
	public int getCurrent_page() {
		return current_page;
	}
	public void setCurrent_page(int current_page) {
		this.current_page = current_page;
	}
	public void setCurrent_page(String current_page) {
		if(current_page != null && current_page.trim().length() >0)
			 this.current_page = Integer.parseInt(current_page);
		else
			this.current_page = 1;
	}
	public int getCurrent_rowscount() {
		return current_rowscount;
	}
	public void setCurrent_rowscount(int current_rowscount) {
		this.current_rowscount = current_rowscount;
	}
	public int getPage_size() {
		if(!this.isSetps){
			try{
				page_size = Integer.parseInt(AppListener.getAppValue("per_pageSize"));
			}catch(Exception x){}
		}
		return page_size;
	}
	public void setPage_size(int page_size) {
		this.isSetps = true;
		this.page_size = page_size;
	}
	public ArrayList getAttribute_param() {
		return attribute_param;
	}
	public void setAttribute_param(ArrayList attribute_param) {
		this.attribute_param = attribute_param;
	}
	public String getPage_sql() {
		return page_sql;
	}
	public void setPage_sql(String page_sql) {
		this.page_sql = page_sql;
	}
	public ResultSet getRs_obj() {
		return rs_obj;
	}
	public void setRs_obj(ResultSet rs_obj) {
		this.rs_obj = rs_obj;
	}
	public MyException getException() {
		return exception;
	}
	public void setException(Exception exception) {
		setExceptionMessage(exception.getMessage());
	}
	public void setExceptionMessage(String msg) {
		if(this.exception == null){
			this.exception = new MyException(msg);
		}else{
			this.exception.setMessage(msg);
		}
	}
	
	public void clearException(){
		this.exception = null;
	}
	public Object getAttribute_value() {
		return attribute_value;
	}
	public void setAttribute_value(Object attribute_value) {
		this.attribute_value = attribute_value;
	}
}
	
	
