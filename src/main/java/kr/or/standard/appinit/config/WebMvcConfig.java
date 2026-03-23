package kr.or.standard.appinit.config;


import kr.or.standard.appinit.interceptor.AjaxInterceptor;
import kr.or.standard.appinit.interceptor.FtInterceptor;
import kr.or.standard.appinit.interceptor.MaInterceptor;
import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.usersupport.lginPlcy.service.LginPlcyService;
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

	private final MaInterceptor maInterceptor;
	private final FtInterceptor ftInterceptor;
	//private final ItsmInterceptor itsmInterceptor;
	private final AjaxInterceptor ajaxInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 관리자 인터셉터
		registry.addInterceptor(maInterceptor).addPathPatterns("/ma/**/*.do");

		// 사용자 인터셉터
		registry.addInterceptor(ftInterceptor).addPathPatterns("/ft/**/*.do");

		// ITSM 요청 인터셉터
		// registry.addInterceptor(itsmInterceptor).addPathPatterns("/itsm/**/*.do");

		// 4. ★ 그 외 모든 요청 (AJAX 공통 처리 등) 인터셉터
		registry.addInterceptor(ajaxInterceptor)
				.addPathPatterns("/**/*.ajx") ; // 모든경로에 ajax인터셉터 적용

	  //registry.addInterceptor(myInterceptor).addPathPatterns("/my/**/*.do");
	}

	@Bean
	@ConfigurationProperties(prefix = "server.error")
	public ErrorProperties errorProperties() {
		return new ErrorProperties();
	}
}


