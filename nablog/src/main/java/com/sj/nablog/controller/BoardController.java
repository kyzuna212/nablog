package com.sj.nablog.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sj.nablog.common.domain.AttachFile;
import com.sj.nablog.common.domain.PagingList;
import com.sj.nablog.model.domain.BoardVO;
import com.sj.nablog.model.service.BoardService;
import com.sj.nablog.model.service.MenuService;
import com.sj.nablog.model.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import net.coobird.thumbnailator.Thumbnailator;



@Controller //스프링의 빈으로 인식 가능
/* @Log4j */
//@RequestMapping("/board/*") //  /board로 시작하는 모든 처리를 함
@AllArgsConstructor  //생성자를 만들고 자동으로 주입(BoardService에 의존적)
					//단, 생성자를 만들지 않을 경우 @Setter(onMethod_={@Autowired})를 이용하여 처리
public class BoardController {
	
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Setter(onMethod_ = {@Autowired})
	private MenuService menuService ;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	@Setter(onMethod_ = {@Autowired})
	private ReplyService replyService;
	
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
	public String moveDetailPage(@RequestParam("bno")int bno,@RequestParam("menuCateNo") int menuCateNo, Model model ) {

		//게시글 조회수 누적
		boardService.updatebView(bno);
		
		//rowNum값 가져오기
		int rowNum =boardService.selectRowNum(bno);
		
		//게시글 번호에 해당하는 댓글 불러오기
		model.addAttribute("reply", replyService.selectList(bno));
		//게시글 번호에 해당하는 게시물 불러오기
		model.addAttribute("board", boardService.selectOne(bno));
		//해당 카테고리에서 게시글 번호 앞뒤 글 최대 5글 불러오기
		model.addAttribute("boardList", boardService.selectConList(bno,menuCateNo,rowNum));
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

		List<AttachFile> list = new ArrayList<AttachFile>();	
		
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
					attachFile.setImageType(true);
					
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
		
	//서버에 전송하는 데이터는 파일의 경로 + _s+uuid가 붙은 파일 이름
	//문자열로 파일의 경로가 포함된 fileName을 파라미터로 받고 byte[]를 전송
	@GetMapping("/display.do")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		File file = new File("c:\\upload\\"+fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			//byte[]로 이미지 파일 전송시 브라우저에 보내주는 MIME타입이 파일의 종류에 따라 달라질 수 있음 ->probeContentType()를 이용하여 해결
			header.add("Content-Type", Files.probeContentType(file.toPath())); 

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//크롬에서는 가능(자동으로 해당 파일을 다운로드), IE에서는 불가능(Content-Disposition의 값을 처리하는 인코딩 방식이 다름),Edge는 또 다름
	//MIME 타입은 다운로드 할 수 있는 application/octet-stream으로 지정
	//HttpServletRequest의 User-Agent의 값 (헤더 메시지 중에서 디바이스 정보를 알 수 있는 헤더) 이용
	@GetMapping(value="/download.do" , produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		Resource resource = new FileSystemResource("c:\\upload\\"+fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		//UUID제거 한 상태의 파일 이름으로 저장
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			
			String downloadName = null;
			
			//IE
			if(userAgent.contains("Trident")) {
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\", " ");
			
			//Edge
			}else if(userAgent.contains("Edge")) {
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			
			//Chrome
			}else {
				
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			//다운로드 시 저장되는 이름은  Content-Disposition를 이용해서 지정
			//파일이름에 대한 문자열 처리 -한글일 경우 저장할 때 깨지는 문제 방지
			headers.add("Content-Disposition", "attachment; filename="+ downloadName); 
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	//첨부파일 삭제
	@PostMapping("/deleteFile.do")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("deleteFile: "+ fileName);
		
		File file;
		
		try {
			//일반 파일, 썸네일 이미지 파일 삭제
			file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			//이미지 파일의 경우 's_'을 제외한 경로에 저장되어 있는 원본 이미지 파일도 같이 삭제함
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName : "+ largeFileName);
				
				file = new File(largeFileName);
				
				file.delete();
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	//게시물 등록
	@PostMapping("/insert.do")
	public String insert(BoardVO board, RedirectAttributes rttr) {
		
		log.info("=====================================");
		
		log.info("insert : "+ board);

		if(board.getAttachList() !=null) {
			
		//	board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("=====================================");
		
		boardService.insert(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/list.do";
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
