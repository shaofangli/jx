package jx.common.interceptor.test;

import java.lang.reflect.Method;

import org.springframework.aop.MethodBeforeAdvice;

public class PurviewBefor2 implements MethodBeforeAdvice{

	public void before(Method arg0, Object[] arg1, Object arg2) throws Throwable {
		System.out.println("This is before2 method");
	}

}
