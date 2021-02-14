package com.sj.nablog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;



@Controller //스프링의 빈으로 인식 가능
/* @Log4j */
@RequestMapping("/board/*") //  /board로 시작하는 모든 처리를 함
@AllArgsConstructor  //생성자를 만들고 자동으로 주입(BoardService에 의존적)
					//단, 생성자를 만들지 않을 경우 @Setter(onMethod_={@Autowired})를 이용하여 처리
public class BoardController {
	
	//목록 페이지로 이동
	@RequestMapping("/list.do")
	public String movePage() {
		return "board/list";
	}
}
