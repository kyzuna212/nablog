package com.sj.nablog.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sj.nablog.common.domain.AttachFile;
import com.sj.nablog.common.domain.PagingList;
import com.sj.nablog.model.domain.BoardVO;
import com.sj.nablog.model.service.BoardService;
import com.sj.nablog.model.service.MenuService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import net.coobird.thumbnailator.Thumbnailator;



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
	@PostMapping(value="/upload.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFile>> uploadAjaxFile(MultipartFile[] uploadFile) {

		List<AttachFile> list = new ArrayList();	
		
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		
		//폴더 만들기
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		//yyyy/MM/dd  폴더를 만들기
		if(uploadPath.exists() ==false) {
			
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			
			//첨부파일  객체 생성
			AttachFile attachFile = new AttachFile();
			
			String uploadFileName = multipartFile.getOriginalFilename(); 
			
			//IE는 file path를 가지고 있음
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			//첨부파일 원본 이름 저장
			attachFile.setFileName(uploadFileName);
			
			//파일 이름 중복으로 인한 삭제 방지를 위한 임의의 값 생성
			UUID uuid = UUID.randomUUID();
			//원래 파일 이름과의 구분위해 _를 추가
			uploadFileName = uuid.toString() + "_" +uploadFileName ;
			
			//첨부파일 저장용 이름 저장
			attachFile.setBRefile(uploadFileName);
			
			try {
				
				//uploadFolder 폴더 경로의 uploadFileName라는 파일에 대한 File 객체를 생성
				//File saveFile = new File (uploadFolder, uploadFileName);
				
				//날짜별로 폴더 지정해서 날짜별로 저장
				File saveFile = new File (uploadPath, uploadFileName);
				
				//multipartFile의 메서드 transferTo(File file) : 파일의 저장
				multipartFile.transferTo(saveFile);
				
				//첨부파일 uuid와 업로드 경로 저장
				attachFile.setUuid(uuid.toString());
				attachFile.setUploadPath(uploadFolderPath);
				
				//이미지 파일 여부 체크 후 맞다면 썸네일 제작
				if(checkImageType(saveFile)) {
					
					//이미지 여부 체크 저장 
					attachFile.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+ uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					//이미지일 경우 저장용 이름 저장
					attachFile.setBRefile("s_"+uploadFileName);
					
					thumbnail.close();
				}
				
				list.add(attachFile);
			}catch(Exception e) {
				e.getMessage();
			}		
			
		}//for end
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//오늘 날짜의 경로를 문자열로 생성 (폴더 저장을 날짜별로 분류하기 위함)
	private  String  getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//Date date = new Date();
		
		String str = sdf.format(new java.sql.Date(System.currentTimeMillis()));
		
		return str.replace("-", File.separator);
	}
	
	//이미지 파일 여부 체크
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
