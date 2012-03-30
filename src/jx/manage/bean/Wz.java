package jx.manage.bean;

public class Wz {
	private String dh;
	private String bt;
	private String zz;
	private String fbrq;
	private String gxrq;
	private String nr;
	private String url;
	
	private String lxmc;
	private String lxdh;
	private String sfzd;
	
    public String getSfzd() {
		return sfzd;
	}


	public void setSfzd(String sfzd) {
		this.sfzd = sfzd;
	}


	public String getLxmc() {
		return lxmc;
	}


	public void setLxmc(String lxmc) {
		this.lxmc = lxmc;
	}


	public String getNr() {
		return nr;
	}


	public void setNr(String nr) {
		this.nr = nr;
	}


	public String getBt() {
		return bt;
	}


	public void setBt(String bt) {
		this.bt = bt;
	}


	public String getDh() {
		return dh;
	}


	public void setDh(String dh) {
		this.dh = dh;
	}


	public String getFbrq() {
		return fbrq.lastIndexOf('.') != -1 ?fbrq.substring(0,fbrq.lastIndexOf('.')):fbrq;
	}


	public void setFbrq(String fbrq) {
		this.fbrq = fbrq;
	}


	public String getZz() {
		return zz;
	}


	public void setZz(String zz) {
		this.zz = zz;
	}


	public void clear(){
    	this.dh = null;
    	this.bt = null;
    	this.zz = null;
    	this.fbrq = null;
    }


	public String getGxrq() {
		return gxrq.lastIndexOf('.') != -1 ?gxrq.substring(0,gxrq.lastIndexOf('.')):gxrq;
	}


	public void setGxrq(String gxrq) {
		this.gxrq = gxrq;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public String getLxdh() {
		return lxdh;
	}


	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
}
