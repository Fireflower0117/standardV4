package kr.or.opennote.appinit.config;


import kr.or.opennote.appinit.interceptor.FtInterceptor;
import kr.or.opennote.appinit.interceptor.MaInterceptor;
import kr.or.opennote.appinit.interceptor.MyInterceptor;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
 
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	   
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new MaInterceptor()).addPathPatterns("/ma/**/*.do"); 
		registry.addInterceptor(new FtInterceptor()).addPathPatterns("/ft/**/*.do");
		registry.addInterceptor(new MyInterceptor()).addPathPatterns("/my/**/*.do");
	}

	@Bean
	@ConfigurationProperties(prefix = "server.error")
	public ErrorProperties errorProperties() {
		return new ErrorProperties();
	}
}


