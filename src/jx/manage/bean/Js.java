package jx.manage.bean;

import java.util.ArrayList;
import java.util.List;

public class Js {
	private String dh;
	private String mc;
	private List mks = new ArrayList();
	 
	public String getDh() {
		return dh;
	}
	public void setDh(String dh) {
		this.dh = dh;
	}
	public String getMc() {
		return mc;
	}
	public void setMc(String mc) {
		this.mc = mc;
	}
	public List getMks() {
		return mks;
	}
	public void setMks(String mks) {
		
		if(mks == null)
			mks = "";
		if(mks.indexOf("$")==-1)
			this.mks.add(mks);
		else{
			for(String tmp : mks.split("$")){
				if(tmp != null && tmp.trim().length() > 0){
					this.mks.add(tmp);
				}
			}
		}
	}
	
    public void clear(){
    	this.dh = null;
    	this.mc = null;
    	this.mks.clear();
    }
}
