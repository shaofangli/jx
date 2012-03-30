package jx.web.bean;

import java.util.ArrayList;

public class Lyb {
	
	private String dh;
	private String zh;
	private String xm;
	private String lyrq;
	private String lynr;
	private String bq;
	private String lx;
	private String sfnm;
	private String sfkj;
	private String pdh;
	
	
	private ArrayList hfs;
	private int hfs_size;
	
	public String getBq() {
		return bq;
	}
	public void setBq(String bq) {
		this.bq = bq;
	}
	public String getDh() {
		return dh;
	}
	public void setDh(String dh) {
		this.dh = dh;
	}
	public String getLx() {
		return lx;
	}
	public void setLx(String lx) {
		this.lx = lx;
	}
	public String getLynr() {
		return lynr;
	}
	public void setLynr(String lynr) {
		this.lynr = lynr;
	}
	public String getLyrq() {
		//System.out.println("--x>"+lyrq);
		return lyrq.lastIndexOf('.') != -1 ?lyrq.substring(0,lyrq.lastIndexOf('.')):lyrq;
	}
	public void setLyrq(String lyrq) {
		this.lyrq = lyrq;
	}
	public String getPdh() {
		return pdh;
	}
	public void setPdh(String pdh) {
		this.pdh = pdh;
	}
	public String getSfkj() {
		return sfkj;
	}
	public void setSfkj(String sfkj) {
		this.sfkj = sfkj;
	}
	public String getSfnm() {
		return sfnm;
	}
	public void setSfnm(String sfnm) {
		this.sfnm = sfnm;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public String getZh() {
		return zh;
	}
	public void setZh(String zh) {
		this.zh = zh;
	}
	public ArrayList getHfs() {
		return hfs;
	}
	public void setHfs(ArrayList hfs) {
		this.hfs = hfs;
		setHfs_size(hfs == null?0:hfs.size());
	}
	public int getHfs_size() {
		return hfs_size;
	}
	public void setHfs_size(int hfs_size) {
		this.hfs_size = hfs_size;
	}
	
	
	
}
