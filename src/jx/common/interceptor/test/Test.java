package jx.common.interceptor.test;

public class Test {
	/**
	 * @param args 运行测试之前把要测试的xml文件移到src目录下;
	 */
	public static void main(String[] args) {
//		ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-resources.xml");
//		
//		JxBasicInterface jx = (JxBasicInterface)ctx.getBean("/index.htm");
//		
//		
//		try {
//			System.out.println(Class.forName(jx.toString().substring(0,jx.toString().lastIndexOf("@"))).newInstance());
//			// jx.selectAction(null, null);jx.web.controller.MutController@17bd6a1
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		//Object obj = new Object();
		A b = new B("xx");
	}

}

class A {
	private Object deleget ;
	public A(){
		System.out.println("A1");
		setDeleget(this);
	}
	public A(Object deleget){
		System.out.println("A2");
		setDeleget(deleget);
	}
	
	public final void setDeleget(Object deleget){
		System.out.println("setDeleget..");
		this.deleget = deleget;
	}
}

class B extends A {
	private Object deleget ;
	public B(){
		this.A();
	}
	public B(Object deleget){
		this.A(deleget);
	}
	public void A(){
		System.out.println("B1");
	}
	public void A(Object deleget){
		System.out.println("B2");
	}
}
