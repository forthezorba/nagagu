package org.nagagu.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.nagagu.domain.AttachFileDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller	
@Log4j 
@RequiredArgsConstructor
public class UploadController{
    private final S3Uploader s3Uploader;
    
    @RequestMapping("/uploadAWS")
    @ResponseBody
    public ResponseEntity<List> upload(@RequestParam("data") MultipartFile[] files,String category) throws IOException {
    	log.info("uploadAWS...");
    	List list= new ArrayList<>();
    	for(MultipartFile multipartFile : files) {
    		AttachFileDTO attachDTO = new AttachFileDTO();
    		attachDTO = s3Uploader.uploadFile(multipartFile, category);
    		list.add(attachDTO);
    	}
    	return new ResponseEntity<>(list,HttpStatus.OK);
    }
    @RequestMapping("/deleteAWS")
	@ResponseBody
	public ResponseEntity<String> delete(String fileName){
		log.info("deleteAWS:.... "+fileName);
		String file = fileName.substring(fileName.indexOf('/',8)+1);
		log.info(file);
		s3Uploader.deleteFile(file);
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
	
//	@GetMapping("/uploadAjax")
//	public void uploadAjax() {
//		log.info("upload ajax");
//	}
//	@PreAuthorize("isAuthenticated()")
//	@PostMapping(value = "/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
//		
//		List<AttachFileDTO> list= new ArrayList<>();
//		String uploadFolder="C:\\project138\\upload";
//		String uploadFolderPath = getFolder();
//		File uploadPath = new File(uploadFolder, uploadFolderPath);
//		log.info("upload path:"+uploadPath);
//		log.info("uploadFolderPath:"+uploadFolderPath);
//		
//		if(uploadPath.exists() == false) {
//			uploadPath.mkdirs();
//		}
//		for(MultipartFile multipartFile : uploadFile) {
//			AttachFileDTO attachDTO = new AttachFileDTO();
//			String uploadFileName= multipartFile.getOriginalFilename();
//			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
//			log.info("only file name"+uploadFileName);
//			attachDTO.setFileName(uploadFileName);
//			UUID uuid = UUID.randomUUID();
//			uploadFileName = uuid.toString()+"_"+uploadFileName;
//			
//			
//			try {
//				File saveFile=new File(uploadPath, uploadFileName);
//				multipartFile.transferTo(saveFile);
//				attachDTO.setUuid(uuid.toString());
//				attachDTO.setUploadPath(uploadFolderPath);
//				//check and make thumbnail
//				if(checkImageType(saveFile)) {
//					attachDTO.setImage(true);
//					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
//					thumbnail.close();
//				}
//				list.add(attachDTO);
//			}catch(Exception e){
//				e.printStackTrace();
//			}
//		}
//		return new ResponseEntity<>(list,HttpStatus.OK);
//	}
//	
//	private String getFolder() {
//		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
//		Date date = new Date();
//		String str= sdf.format(date);
//		return str;
//	}
//	
//	private boolean checkImageType(File file) {
//		try {
//			String contentType = Files.probeContentType(file.toPath());
//			return contentType.startsWith("image");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return false;
//	}
//	
//	@GetMapping("/display")
//	@ResponseBody
//	public ResponseEntity<byte[]> getFile(String fileName){
//		log.info("filename: "+fileName);
//		File file = new File("C:\\project138\\upload\\"+fileName);
//		  
//		log.info("file="+file);
//		
//		ResponseEntity<byte[]> result = null;
//		
//		try {
//			HttpHeaders header = new HttpHeaders();
//			header.add("Content-type", Files.probeContentType(file.toPath()));
//			result=new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
//		}catch(IOException e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
//	
//	@GetMapping(value="/download",produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
//	@ResponseBody
//	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
//		log.info("downfile:"+ fileName);
//		Resource resource = new FileSystemResource("C:\\projecct138\\upload\\"+fileName);
//		log.info("resource:"+resource);
//		if(resource.exists()==false) {
//			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//		}
//		String resourceName = resource.getFilename();
//		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_"+1));
//		HttpHeaders headers = new HttpHeaders();
//		try {
//			String downloadName = null;
//			if(userAgent.contains("Trident")) {
//				log.info("IE");
//				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
//			}
//			else if(userAgent.contains("Edge")) {
//				log.info("edge");
//				downloadName= URLEncoder.encode(resourceOriginalName,"UTF-8");
//			}else {
//				log.info("chrome");
//				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
//			}
////			if (checkIE) {
////				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replaceAll("\\+", " ");
////			} else {
////				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
////			}
//			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
//	}
//	@PreAuthorize("isAuthenticated()")
//	@PostMapping("/deleteFile")
//	@ResponseBody
//	public ResponseEntity<String> deleteFile(String fileName, String type){
//		//String src = fileName.replace("http://localhost:8000/communityupload/image", "");
//		log.info("deleteFile:.... "+fileName);
//		File file;
//		try{
//			file = new File("C:\\project138\\upload\\"+ URLDecoder.decode(fileName,"UTF-8"));
//			file.delete();
//			if(type.equals("image")) {
//				log.info(file.getAbsolutePath());
//				String largeFileName=  file.getAbsolutePath().replace("s_", "");
//				log.info("largeFileName"+largeFileName);
//				file = new File(largeFileName);
//				file.delete();
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//		}
//		return new ResponseEntity<String>("deleted",HttpStatus.OK);
//	}
	
}
