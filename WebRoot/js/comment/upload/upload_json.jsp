<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.util.*,java.io.*,java.awt.*,com.sun.image.codec.jpeg.*,java.awt.image.BufferedImage" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.json.simple.*" %>
<%
//文件保存目录路径
String savePath = pageContext.getServletContext().getRealPath("/") + "images/uploadimgs/"+request.getParameter("zdy_tpth")+"/";
//文件保存目录URL
String saveUrl  = request.getContextPath() + "/images/uploadimgs/"+request.getParameter("zdy_tpth")+"/";
//定义允许上传的文件扩展名
String[] fileTypes = new String[]{"gif", "jpg", "jpeg", "png", "bmp"};
//最大文件大小
long maxSize = 1048576;

response.setContentType("text/html; charset=UTF-8");

if(!ServletFileUpload.isMultipartContent(request)){
	out.println(getError("请选择文件."));
	return;
}
//检查目录
File uploadDir = new File(savePath);
if(!uploadDir.isDirectory()){
	out.println(getError("上传目录不存在."));
	return;
}
//检查目录写权限
if(!uploadDir.canWrite()){
	out.println(getError("上传目录没有写权限."));
	return;
}

FileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");
List items = upload.parseRequest(request);
Iterator itr = items.iterator();
while (itr.hasNext()) {
	FileItem item = (FileItem) itr.next();
	String fileName = item.getName();
	if (!item.isFormField()) {
		//检查文件大小
		if(item.getSize() > maxSize){
			out.println(getError("上传文件大小超过限制.最大1MB!"));
			return;
		}
		//检查扩展名
		String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
		if(!Arrays.<String>asList(fileTypes).contains(fileExt)){
			out.println(getError("上传文件扩展名是不允许的扩展名."));
			return;
		}
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
		try{
			File uploadedFile = new File(savePath, newFileName);
			item.write(uploadedFile);
			int zdy_w = 0;
			int zdy_h = 0;
			try{
				zdy_w = Integer.parseInt(request.getParameter("zdy_w"));
				zdy_h = Integer.parseInt(request.getParameter("zdy_h"));
			}catch(Exception x){}
			Tosmallerpic(savePath,uploadedFile,null,zdy_w,zdy_h,(float)0.7);
		}catch(Exception e){
			out.println(getError("上传文件失败."));
			return;
		}
		JSONObject obj = new JSONObject();
		obj.put("error", 0);
		obj.put("url", saveUrl + newFileName);
		out.println(obj.toJSONString());
	}
}
%>
<%!
private String getError(String message) {
	JSONObject obj = new JSONObject();
	obj.put("error", 1);
	obj.put("message", message);
	return obj.toJSONString();
}
//* @param f_directory 图片所在的文件夹路径 
//* @param source_file 图片路径 
//* @param zdy_fileNm 自定义图片名字(null则用源图片名)
//* @param w 目标宽
//* @param h 目标高
//* @param per 清晰度百分比(越大质量越好)
private void  Tosmallerpic(String f_directory,File source_file,String zdy_fileNm,int w,int h,float per){
    Image src; 
    try{
	       src = javax.imageio.ImageIO.read(source_file); //构造Image对象 
	       String img_midname=f_directory+(zdy_fileNm==null?source_file.getName():zdy_fileNm+source_file.getName().substring(source_file.getName().lastIndexOf('.'))); 
	       int old_w=src.getWidth(null); //得到源图宽 
	       int old_h=src.getHeight(null);//得到源图长 
	       int new_w=0; 
	       int new_h=0; 
	
	       double w2=(old_w*1.00)/(w*1.00); 
	       double h2=(old_h*1.00)/(h*1.00); 
	
	       if(old_w>w && w!=0) 
	       		new_w=(int)Math.round(old_w/w2); 
	       else 
	            new_w=old_w; 
	       if(old_h>h && w!=0) 
	       		new_h=(int)Math.round(old_h/h2);
	       else
	            new_h=old_h;
	       BufferedImage tag = new BufferedImage(new_w,new_h,BufferedImage.TYPE_INT_RGB);        
	       //tag.getGraphics().drawImage(src,0,0,new_w,new_h,null); //绘制缩小后的图 
	       tag.getGraphics().drawImage(src.getScaledInstance(new_w, new_h,  Image.SCALE_SMOOTH), 0,0,null); 
	       FileOutputStream newimage=new FileOutputStream(img_midname); //输出到文件流 
	       JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage); 
	       JPEGEncodeParam jep=JPEGCodec.getDefaultJPEGEncodeParam(tag); 
	        /* 压缩质量 */ 
	       jep.setQuality(per, true); 
	       encoder.encode(tag, jep); 
	       //encoder.encode(tag); //近JPEG编码 
	       newimage.close();
       } catch (IOException ex) {
    	   getError(ex.getMessage());
   	   }
} 
%>