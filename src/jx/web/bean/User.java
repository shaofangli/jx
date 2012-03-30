package jx.web.bean;

public class User {
	
	private String zh;
	private String mm;
	private String xm;
	private String xb;
	private String yx;
	private String dh;
	private String csrq;
	private String zcsj;
	private String zhdl;
	private String jsdh;
	private String jsmc;
	private String mmbhwt;
	private String mmbhda;
	private String sfjh;
	private String grjj;
	private String bz;
	
	private String mks;
	
	public String getMks() {
		return mks;
	}
	public void setMks(String mks) {
		this.mks = mks;
	}
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
	public String getCsrq() {
		return csrq;
	}
	public void setCsrq(String csrq) {
		this.csrq = csrq;
	}
	public String getDh() {
		return dh;
	}
	public void setDh(String dh) {
		this.dh = dh;
	}
	public String getGrjj() {
		return grjj;
	}
	public void setGrjj(String grjj) {
		this.grjj = grjj;
	}
	public String getJsdh() {
		return jsdh;
	}
	public void setJsdh(String jsdh) {
		this.jsdh = jsdh;
	}
	public String getMm() {
		return mm;
	}
	public void setMm(String mm) {
		this.mm = mm;
	}
	public String getMmbhda() {
		return mmbhda;
	}
	public void setMmbhda(String mmbhda) {
		this.mmbhda = mmbhda;
	}
	public String getMmbhwt() {
		return mmbhwt;
	}
	public void setMmbhwt(String mmbhwt) {
		this.mmbhwt = mmbhwt;
	}
	public String getSfjh() {
		return sfjh;
	}
	public void setSfjh(String sfjh) {
		this.sfjh = sfjh;
	}
	public String getXb() {
		return xb;
	}
	public void setXb(String xb) {
		this.xb = xb;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public String getYx() {
		return yx;
	}
	public void setYx(String yx) {
		this.yx = yx;
	}
	public String getZcsj() {
		return zcsj.lastIndexOf('.') != -1 ?zcsj.substring(0,zcsj.lastIndexOf('.')):zcsj;
	}
	public void setZcsj(String zcsj) {
		this.zcsj = zcsj;
	}
	public String getZh() {
		return zh;
	}
	public void setZh(String zh) {
		this.zh = zh;
	}
	public String getZhdl() {
		return zhdl;
	}
	public void setZhdl(String zhdl) {
		this.zhdl = zhdl;
	}
	public String getJsmc() {
		return jsmc;
	}
	public void setJsmc(String jsmc) {
		this.jsmc = jsmc;
	}
	
	
}
