package org.medipaw.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Component
@Log4j
public class LogAdvice {
	
	@Around("execution(* org.zerock.service.SampleService*.*(..))")
	public Object logAround(ProceedingJoinPoint pjp) {
		log.info("pjp : " + pjp);
		
		Object result = null;
		
		log.info("TARGET: " + pjp.getTarget());
		log.info("PARAM : " + Arrays.toString(pjp.getArgs()));
		
		try {
			result = pjp.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		log.info("result : " + result);
		return result;
	}
	
	@AfterThrowing(
			pointcut = "execution(* org.zerock.service.SampleService*.*(..))",
			throwing = "exception")
	public void logExeption(Exception exception) {
		log.info("SampleService Exception!!!");
		log.info("exception : " + exception);
	}
	
	@Before("execution(* org.zerock.service.SampleService*.doAdd(String, String))&& args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1 :" + str1);
		log.info("str2 :" + str2);
	}
	
	@Before("execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("----------------------------");
	}

}
