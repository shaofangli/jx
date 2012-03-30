package jx.common.tools.sendmail;

import java.util.Properties;

import jx.common.listeners.AppListener;

public class Mail {
	
	//public static ResourceBundle p = ResourceBundle.getBundle("log4j");
	
	private static Properties p = AppListener.getPops();
	
	private SMTPExtAppender smtpmail = null; 
	//显示发送人昵称
	private String sendName = null;
	
    private String from = null;
    //标题
    private String subject = null;

    private String smtpHost = null;
 
    private String smtpUsername = null;

    private String smtpPassword = null;

    private String smtpAuth = "true";    
    //内容
    private String msg ;
    
    /**
     * 
     * @param msg 发送内容
     * @param to  发送给
     * @param subject 发送标题
     */
    public Mail(String msg,String to){
		
    	this.sendName = p.getProperty("sendName").trim();
		this.from = p.getProperty("emailAddres").trim();
		this.smtpHost = p.getProperty("stmpHost").trim();
		this.smtpUsername = p.getProperty("userName").trim();
		this.smtpPassword = p.getProperty("userPassword").trim();
		this.subject = p.getProperty("subject").trim();
    	 
    	smtpmail = new SMTPExtAppender();
    	smtpmail.setSendName(this.sendName);
    	smtpmail.setFrom(this.from);
    	smtpmail.setTo(to);
    	smtpmail.setSubject(this.subject);
    	smtpmail.setSMTPHost(this.smtpHost);
    	smtpmail.setSMTPUsername(this.smtpUsername);
    	smtpmail.setSMTPPassword(this.smtpPassword);
    	smtpmail.setSMTPAuth(this.smtpAuth);
    	this.msg = msg;
    }
    
    public static String getCommonMailMsg(String xm,String zh,String mm){
//    	return "您好！<p/>您在长沙驾校网(http://localhost:7070/jx/)注册了帐户,激活后才能使用.<br/>" +
//    			"点击下面的链接立即激活帐户(或将链接地址复制到浏览器中打开):<br/>" +
//    			"http://localhost:7070/jx/web/reg.htm?method=ActivationUsr&zh="+zh;
    	
    	return "<div class=\"headad\" style=\"width:600px; height:94px; background-image:url("+p.getProperty("wz_dz")+"images/adhead.gif);margin-left:auto; margin-right:auto;\"> </div>"+
    	"<div class=\"adzhuti\" style=\"width:600px; height:auto; margin-left:auto; margin-right:auto;\"> <div class=\"add\">"+
    	"<table style=\"border: 1px solid rgb(204, 204, 204);\" align=\"center\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" height=\"200\" width=\"100%\">"+
    	"<tbody><tr><td><p>&nbsp;</p><p>尊敬的 "+xm+",您好!</p>"+
    	"<p>　　恭喜您已经成功注册为"+p.getProperty("wz_title")+"会员，请 <a target=\"_blank\" href=\""+p.getProperty("wz_dz")+"web/reg.htm?method=ActivationUsr&zh="+zh+"\">点击这里激活帐号</a>."+
    	"<br />如果以上链接无效，请将以下地址复制到浏览器地址栏中打开： <br />"+""+p.getProperty("wz_dz")+"web/reg.htm?method=ActivationUsr&zh="+zh+"</p>"+
    	"<p>　　您的登陆账号是："+zh+"<br />　　登陆密码是："+mm+"<br /><br />建议您保管好本邮件！如忘记密码，请打开<a href=\""+p.getProperty("wz_dz")+"\" target=\"_blank\">网站首页</a>,在登录对话框点击找回密码即可.</p><p>&nbsp;</p></td></tr>"+
    	"<tr align=\"center\"><td><img src=\""+p.getProperty("wz_dz")+"images/addd.gif\" width=\"448\" height=\"278\" /></td></tr></tbody></table></div></div>";
    }
    
    //�����ʼ�;
    public void sendMessage() throws Exception{
    	 smtpmail.activateOptions();
    	 smtpmail.sendMessage(this.msg);
    }
    
//    public   static   void   main(String   args[]) 
//    { 
//    	Mail sm=new  Mail(Mail.getCommonMailMsg(),"1420029935@qq.com","-驾校注册信件-");
//    	try {
//			sm.sendMessage();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//    }

}
