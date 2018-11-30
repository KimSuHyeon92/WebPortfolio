package com.pf.test;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Set;

import org.apache.ibatis.type.Alias;
import org.reflections.Reflections;
import org.reflections.scanners.SubTypesScanner;
import org.springframework.web.bind.annotation.RequestMapping;

public class NamingReflection {

	public static void main(String[] args) {
		System.out.println("이름 : 김수현 \t 평가일 : 2017-11-15");
		
		// 패키지에서 모든 클래스 추출
		Reflections reflections = new Reflections("com.pf", new SubTypesScanner(false));

		Set<Class<? extends Object>> allClasses = reflections.getSubTypesOf(Object.class);

		ArrayList<Class<?>> controllers = new ArrayList<Class<?>>();
		ArrayList<Class<?>> services = new ArrayList<Class<?>>();
		ArrayList<Class<?>> daos = new ArrayList<Class<?>>();
		ArrayList<Class<?>> dtos = new ArrayList<Class<?>>();
		
		for (Class clazz : allClasses) {
			String sName = clazz.getSimpleName();
			
			// DTO 찾기
			if(clazz.getName().toLowerCase().indexOf("dto") > 0 || clazz.isAnnotationPresent(Alias.class)){
				dtos.add(clazz);
			}
			
			// 컨트롤러 찾기
			if(sName.toLowerCase().indexOf("controller") > 0){
				controllers.add(clazz);
			}
			
			// 서비스 
			if(sName.toLowerCase().indexOf("service") > 0){
				// test 클래스, 구현체 제외
				if(sName.toLowerCase().indexOf("test") < 0 && sName.indexOf("Impl") < 0)
					services.add(clazz);
			}
			
			// DAO 찾기
			if(sName.toLowerCase().indexOf("dao") > 0){
				daos.add(clazz);
			}
		}
		System.out.println("Controller ------------------------------------------------");
		// 컨트롤러 추출
		for(Class clazz : controllers){
			System.out.println("\t "+clazz.getName());
			Method[] methods = clazz.getMethods();
			
			for (Method m : methods){
				if(testMethodName(m)){
					
					// 메서드명 & RequestMapping 명 출력
					System.out.println("\t\t method name : " + m.getName());
					if (m.isAnnotationPresent(RequestMapping.class)) {
						RequestMapping ta = m.getAnnotation(RequestMapping.class);
						
						String[] annotations = ta.value();
						for(String a : annotations){
							System.out.println("\t\t               " + a.substring(a.lastIndexOf("/")+1, a.length()));
						}
					}
				}
			}
		}
		System.out.println("Service ------------------------------------------------");
		// Service 추출
		for(Class clazz : services){
			System.out.println("\t "+clazz.getName());
			Method[] methods = clazz.getMethods();
			
			for (Method m : methods){
				if(testMethodName(m)){
					
					// 메서드명 & RequestMapping 명 출력
					System.out.println("\t\t method name : " + m.getName());
					if (m.isAnnotationPresent(RequestMapping.class)) {
						RequestMapping ta = m.getAnnotation(RequestMapping.class);
						
						String[] annotations = ta.value();
						for(String a : annotations){
							System.out.println("\t\t               " + a.substring(a.lastIndexOf("/")+1, a.length()));
						}
					}
				}
			}
		}
		System.out.println("DAO ------------------------------------------------");
		// DAO 추출
		for(Class clazz : daos){
			System.out.println("\t "+clazz.getName());
			Method[] methods = clazz.getMethods();
			
			for (Method m : methods){
				if(testMethodName(m)){
					
					// 메서드명 & RequestMapping 명 출력
					System.out.println("\t\t method name : " + m.getName());
					if (m.isAnnotationPresent(RequestMapping.class)) {
						RequestMapping ta = m.getAnnotation(RequestMapping.class);
						
						String[] annotations = ta.value();
						for(String a : annotations){
							System.out.println("\t\t               " + a.substring(a.lastIndexOf("/")+1, a.length()));
						}
					}
				}
			}
		}
		System.out.println("DTO ------------------------------------------------");
		// DTO 추출
		for(Class clazz : dtos){
			System.out.println("\t "+clazz.getName());
			if (clazz.isAnnotationPresent(Alias.class)) {
				Alias ta = (Alias) clazz.getAnnotation(Alias.class);
				
				System.out.println("\t\tAlias \t" + ta.value());
			}
			Field[] fields = clazz.getDeclaredFields();
			for (Field f : fields){
				System.out.println("\t\t"+ f.getType().getSimpleName()+" \t "+ f.getName());
			}
		}
	}
	
	public static boolean testMethodName(Method method){
		return (! method.getName().equals("wait") &&
						! method.getName().equals("equals") &&
						! method.getName().equals("toString") &&
						! method.getName().equals("hashCode") &&
						! method.getName().equals("getClass") &&
						! method.getName().equals("notify") &&
						! method.getName().equals("notifyAll") );
	}
}
