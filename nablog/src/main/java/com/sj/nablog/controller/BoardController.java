package com.sj.nablog.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sj.nablog.common.domain.PagingList;
import com.sj.nablog.model.domain.BoardVO;
import com.sj.nablog.model.service.BoardService;
import com.sj.nablog.model.service.MenuService;

import lombok.AllArgsConstructor;
import lombok.Setter;



@Controller //스프링의 빈으로 인식 가능
/* @Log4j */
//@RequestMapping("/board/*") //  /board로 시작하는 모든 처리를 함
@AllArgsConstructor  //생성자를 만들고 자동으로 주입(BoardService에 의존적)
					//단, 생성자를 만들지 않을 경우 @Setter(onMethod_={@Autowired})를 이용하여 처리
public class BoardController {
	
	@Setter(onMethod_ = {@Autowired})
	private MenuService menuService ;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	//목록 페이지로 이동
	@RequestMapping("/list.do")
	public String movePage(BoardVO boardVO,@RequestParam(value="pg", defaultValue="1") int pg, Model model) {
		
		PagingList pagingList = new PagingList(pg ,boardService.selectTotalCount(boardVO) , 9.0f );		
		model.addAttribute("pagingList", pagingList );
		model.addAttribute("boardList", boardService.selectList(boardVO.getMenuCateNo()));
		model.addAttribute("menu", menuService.selectOne(boardVO.getMenuCateNo()));
	//	System.out.println(pagingList.toString());
				
		return "board/list";
	}
	
	//상세 페이지로 이동
	@RequestMapping("/detail.do")
	public String moveDetailPage(Model model) {

		return "board/detail";
	}
	
	//글쓰기 페이지로 이동
	@RequestMapping("/edit.do")
	public String moveEditPage(@RequestParam("menuCateNo") int menuCateNo,Model model) {
		model.addAttribute("menu", menuService.selectOne(menuCateNo));
		return "board/edit";
	}
	
	//전체 검색하기
	@RequestMapping("/search.do")
	public String searchText(BoardVO boardVO,@RequestParam(value="pg", defaultValue="1") int pg, Model model) {
		
		model.addAttribute("pagingList", new PagingList(pg ,boardService.selectTotalCount(boardVO.getSearch()) ,9.0f ));
		model.addAttribute("boardList", boardService.selectFindList(boardVO));
	//	model.addAttribute("menu", menuService.selectOne(boardVO.getMenuCateNo()));
		
		return "board/list";
	}
	
	//파일 업로드
	@PostMapping("/upload.do")
	public void uploadAjaxFile(MultipartFile[] uploadFile) {
		
		String uploadFolder = "C:\\upload";
		
		for(MultipartFile multipartFile : uploadFile) {
			
			String uploadFileName = multipartFile.getOriginalFilename(); 
			
			//IE는 file path를 가지고 있음
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			//uploadFolder 폴더 경로의 uploadFileName라는 파일에 대한 File 객체를 생성
			File saveFile = new File (uploadFolder, uploadFileName);
			
			try {
				//multipartFile의 메서드 transferTo(File file) : 파일의 저장
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				e.getMessage();
			}		
			
		}
	}
}
