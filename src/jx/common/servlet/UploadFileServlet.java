package jx.common.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jx.common.tools.fileUpload.HttpFileUpload;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
 

public class UploadFileServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse respons) throws ServletException, IOException {
		//System.out.println("-->Post");
		doprocess(  request,   respons) ;
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse respons) throws ServletException, IOException {
		//System.out.println("-->Get");
		doprocess(  request,   respons) ;
	}
	private void doprocess(HttpServletRequest request, HttpServletResponse respons) throws ServletException, IOException {
		   request.setCharacterEncoding("UTF-8");
		   respons.setCharacterEncoding("UTF-8");
		   
		   PrintWriter out = respons.getWriter();
		   
		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   HttpFileUpload fu = new HttpFileUpload(factory);
		   
		   factory.setSizeThreshold(4096);
		   factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		   try
		   {
		       List fileItemList = fu.parseRequest(request);
		       Iterator fileItemListIte = fileItemList.iterator();
		       while (fileItemListIte.hasNext())
		       {
		           FileItem file = (FileItem) fileItemListIte.next();
		           
		           if(file.getSize() >0)
		           {
		        	   out.println("源文件路径:"+file.getName()+"<br>保存至路径:"+HttpFileUpload.saveRelFile(file)+ "<br>文件大小:" + file.getSize()/1024+"KB<br><br>");
		           }
		       }
		   }
		   catch (Exception e)
		   {
			   out.println("上传失败<br>");
			   out.println(e.getMessage());
		       if (e instanceof HttpFileUpload.InvalidFileUploadException)
		       {
		    	   out.println("<p>以下文件不被允许</p>");
		           Iterator unAllowFileS = ((HttpFileUpload.InvalidFileUploadException) e)
		               .getInvalidFileList().iterator();
		           while (unAllowFileS.hasNext())
		           {
		        	   out.println((String) unAllowFileS.next() + "<br>");
		           }           
		       }

		   }
		   finally
		   {
		       try {
		    	   Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
		       fu.dispose();
		   }
	}
}
