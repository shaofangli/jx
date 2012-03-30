package jx.common.exceptions;

public class MyException extends Exception{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -861175949867168163L;
	private String msg;
	private Throwable throwable;
	
	public MyException(){
		
	}
	public MyException(String arg0){
		this.msg = arg0;
	}
	public MyException(String arg0,Throwable throwable){
		this.msg = arg0;
		this.throwable = throwable;
	}
	
	@Override
	public synchronized Throwable fillInStackTrace() {
		return this.throwable;
	}

	@Override
	public String getMessage() {
		return this.msg;
	}

	public void setMessage(String msg) {
		 this.msg = msg;
	}

	@Override
	public String toString() {
		return this.msg;
	}
	
}
