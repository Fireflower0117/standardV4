package kr.or.standard.appinit.config;


import kr.or.standard.appinit.interceptor.FtInterceptor;
import kr.or.standard.appinit.interceptor.MaInterceptor;
import kr.or.standard.appinit.interceptor.MyInterceptor;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.system.logo.service.LogoService;
import kr.or.standard.basic.system.menu.servie.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
 
@Configuration
@RequiredArgsConstructor
public class WebMvcConfig implements WebMvcConfigurer {
 	  
	private final MenuService menuService;
	private final LginPlcyService lginPlcyService;
	private final LogoService logoService;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new MaInterceptor(menuService , lginPlcyService, logoService )).addPathPatterns("/ma/**/*.do"); 
		registry.addInterceptor(new FtInterceptor()).addPathPatterns("/ft/**/*.do");
		registry.addInterceptor(new MyInterceptor()).addPathPatterns("/my/**/*.do");
	}

	@Bean
	@ConfigurationProperties(prefix = "server.error")
	public ErrorProperties errorProperties() {
		return new ErrorProperties();
	}
}


