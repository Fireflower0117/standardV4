package kr.or.opennote.appinit.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;
import org.thymeleaf.spring5.SpringTemplateEngine;
import org.thymeleaf.spring5.view.ThymeleafViewResolver;

@Slf4j
@Configuration
public class ViewResolverConfig {
	
	 
	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer tilesConfigurer = new TilesConfigurer(); 
		tilesConfigurer.setDefinitions("/WEB-INF/config/viewResolver/tiles/tiles-def-itsm.xml");
		tilesConfigurer.setDefinitions("/WEB-INF/config/viewResolver/tiles/tiles-def-project.xml"); 
		tilesConfigurer.setCheckRefresh(true); 
		return tilesConfigurer;
	}

	@Bean
	public TilesViewResolver tilesViewResolver() {
		TilesViewResolver tilesViewResolver = new TilesViewResolver(); 
		tilesViewResolver.setViewClass(TilesView.class);
		tilesViewResolver.setOrder(1);  // 1순위 확인 tiles 패턴
		return tilesViewResolver;
	} 
  	
	@Bean
	public ThymeleafViewResolver thymeleafViewResolver(SpringTemplateEngine engine) {
		ThymeleafViewResolver v = new ThymeleafViewResolver();
		v.setTemplateEngine(engine);
		v.setOrder(2); // 2순위 확인 thymeleaf 패턴  thymeleaf/*로 시작하는 모든 패턴                
		v.setViewNames(new String[]{"thymeleaf/*"}); // 이 패턴만 Thymeleaf로 처리 ( rerurn viewName이 thymeleaf/로 시작하는경우 )
		return v;
	} 
	
	@Bean
    public InternalResourceViewResolver jspViewResolver() {
        InternalResourceViewResolver r = new InternalResourceViewResolver();
        r.setViewClass(JstlView.class);
        r.setPrefix("/WEB-INF/jsp/");
        r.setSuffix(".jsp"); 
        r.setOrder(3);   // 3순위 확인 jsp InternalResourceView 
        return r;
    } 
}
