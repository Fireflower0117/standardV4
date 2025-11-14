package kr.or.standard.appinit.config;


import java.util.HashMap;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.trace.LeaveaTrace;
import org.egovframe.rte.fdl.cmmn.trace.handler.DefaultTraceHandler;
import org.egovframe.rte.fdl.cmmn.trace.manager.DefaultTraceHandleManager;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.DefaultPaginationManager;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationRenderer;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.AntPathMatcher;

import kr.or.standard.appinit.pagination.CustomPaginationRenderer;
import kr.or.standard.appinit.pagination.DefaultPaginationRenderer;
import kr.or.standard.appinit.pagination.ManagePaginationRenderer;
import kr.or.standard.appinit.pagination.PopAddPaginationRenderer;
import kr.or.standard.appinit.pagination.PopLayoutPaginationRenderer;

/**
 * 전자정부프레임워크 공통컴포넌트 4.1.2 all-in-one 보안강화 패치
 * src > main > resources > egovframework > spring > com
 * context-common.xml to EgovConfig.java
 */
@Configuration
public class EgovConfig {
	@Bean
	public LeaveaTrace leaveaTrace(@Qualifier("egov.traceHandlerService") DefaultTraceHandleManager defaultTraceHandleManager) {
		LeaveaTrace leaveaTrace = new LeaveaTrace();
		leaveaTrace.setTraceHandlerServices(new DefaultTraceHandleManager[]{defaultTraceHandleManager});
		return leaveaTrace;
	}

	@Bean("egov.traceHandlerService")
	public DefaultTraceHandleManager defaultTraceHandleManager(
			@Qualifier("egov.antPathMater") AntPathMatcher antPathMatcher,
			@Qualifier("egov.defaultTraceHandler") DefaultTraceHandler defaultTraceHandler
	) {
		DefaultTraceHandleManager defaultTraceHandleManager = new DefaultTraceHandleManager();
		defaultTraceHandleManager.setReqExpMatcher(antPathMatcher);
		defaultTraceHandleManager.setPatterns(new String[]{"*"});
		defaultTraceHandleManager.setHandlers(new DefaultTraceHandler[]{defaultTraceHandler});
		return defaultTraceHandleManager;
	}

	@Bean("egov.antPathMater")
	public AntPathMatcher antPathMatcher() {
		return new AntPathMatcher();
	}

	@Bean("egov.defaultTraceHandler")
	public DefaultTraceHandler defaultTraceHandler() {
		return new DefaultTraceHandler();
	}
	
	/**
	 * 전자정부 pagination default renderer.
	 * @return DefaultPaginationRenderer
	 */
	@Bean
	public DefaultPaginationRenderer defaultPaginationRenderer() {
		return new DefaultPaginationRenderer();
	}
	@Bean
	public ManagePaginationRenderer managePaginationRenderer() {
		return new ManagePaginationRenderer();
	}
	
	@Bean
	public CustomPaginationRenderer customPaginationRenderer() {
		return new CustomPaginationRenderer();
	}
	
	@Bean
	public PopAddPaginationRenderer popAddPaginationRenderer() {
		return new PopAddPaginationRenderer();
	}
	
	@Bean
	public PopLayoutPaginationRenderer popLayoutPaginationRenderer() {
		return new PopLayoutPaginationRenderer();
	}
	
	/**
	 * 전자정부 default pagination manager 설정.
	 * @return DefaultPaginationManager
	 */
	@Bean
	public DefaultPaginationManager paginationManager() {
		DefaultPaginationManager defaultPaginationManager = new DefaultPaginationManager();
		Map<String, PaginationRenderer> rendererMap = new HashMap<>();
		rendererMap.put("default", defaultPaginationRenderer());
		rendererMap.put("manage", managePaginationRenderer());
		rendererMap.put("custom", customPaginationRenderer());
		rendererMap.put("popAdd", popAddPaginationRenderer());
		rendererMap.put("popLayout", popLayoutPaginationRenderer());
		defaultPaginationManager.setRendererType(rendererMap);
		return defaultPaginationManager;
	}
}

