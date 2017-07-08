package com.cn.hnust.aop;

import java.lang.annotation.*;
/**  
 *自定义注解 拦截Controller  
 */    
@Target({ElementType.PARAMETER, ElementType.METHOD})    
@Retention(RetentionPolicy.RUNTIME)   
@Inherited 
@Documented    
public  @interface SystemControllerLog {    
    
    String description()  default "";    
    
    
} 