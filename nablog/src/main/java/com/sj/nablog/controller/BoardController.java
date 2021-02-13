package com.sj.nablog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/*@Log4j*/
@Controller
public class BoardController {

	@RequestMapping("/list.do")
	public String movePage() {
		return "board/list";
	}
}
