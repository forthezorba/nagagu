package org.nagagu.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;

import org.nagagu.domain.AttachFileDTO;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import lombok.extern.log4j.Log4j;
@Log4j
@Component
public class S3Uploader {
    //private AmazonS3Client amazonS3Client;
    private AmazonS3 amazonS3Client;
    private String bucket;	
    public String getBucket() {
		return bucket;
	}
	public void setBucket(String bucket) {
		this.bucket = bucket;
	}

	public S3Uploader() {
    	this.amazonS3Client= AmazonS3ClientBuilder.standard()
//	            .withCredentials(new ProfileCredentialsProvider())
	            .withRegion(Regions.AP_NORTHEAST_2) 
	            .build();
    }
    
    public void deleteFile(String fileName) {
        log.info(fileName);
        this.bucket="nagagu";
        amazonS3Client.deleteObject(this.getBucket(), fileName);
    }
    
    public AttachFileDTO uploadFile(MultipartFile multipartFile,String categoryDir) {
    	this.bucket="nagagu";
    	String uploadImageUrl = null;
    	
    	ObjectMetadata meta= new ObjectMetadata();
    	meta.setContentType(MediaType.IMAGE_PNG_VALUE);
    	meta.setContentLength(multipartFile.getSize());
    	
    	File file = new File(multipartFile.getOriginalFilename());
    	UUID uuid = UUID.randomUUID();
		String name = uuid.toString()+"_"+file.getName();
    	String fileName = categoryDir + "/" + getFolder() + "/" + name;
    	
    	
    	AttachFileDTO attachDTO = new AttachFileDTO();
    	attachDTO.setFileName(fileName);
    	attachDTO.setUuid(uuid.toString());
		attachDTO.setUploadPath(getFolder());
		attachDTO.setImage(true);
		
    	log.info("before put s3..."+fileName);
    	
    	try {
    		amazonS3Client.putObject(new PutObjectRequest(bucket, fileName,multipartFile.getInputStream(),meta).withCannedAcl(CannedAccessControlList.PublicRead));
    		uploadImageUrl = amazonS3Client.getUrl(bucket, fileName).toString();
    	}catch(IOException e) {
    		e.printStackTrace();
    	}
    	log.info("url..."+uploadImageUrl);
    	attachDTO.setUrl(uploadImageUrl);
    	
    	return attachDTO;
    }
	private String getFolder() {
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str= sdf.format(date);
		return str;
	}
  

//    public String upload(MultipartFile multipartFile, String dirName) throws IOException {
//        log.info("upload method...");
//        this.bucket="nagagu";
//    	File uploadFile = convert(multipartFile)
//                .orElseThrow(() -> new IllegalArgumentException("MultipartFile -> File로 전환이 실패했습니다."));
//
//        return upload(uploadFile, dirName);
//    }
//
//    private String upload(File uploadFile, String dirName) {
//    	log.info("upload 2 method...");
//        String fileName = dirName + "/" + uploadFile.getName();
//        String uploadImageUrl = putS3(uploadFile, fileName);
//        removeNewFile(uploadFile);
//        return uploadImageUrl;
//    }
//	
//    private String putS3(File uploadFile, String fileName) {
//    	log.info("puts3...");
//        amazonS3Client.putObject(new PutObjectRequest(bucket, fileName, uploadFile).withCannedAcl(CannedAccessControlList.PublicRead));
//        return amazonS3Client.getUrl(bucket, fileName).toString();
//    }
//
//
//    private void removeNewFile(File targetFile) {
//    	log.info("remove method...");
//        if (targetFile.delete()) {
//            log.info("파일이 삭제되었습니다.");
//        } else {
//            log.info("파일이 삭제되지 못했습니다.");
//        }
//    }
//
//    private Optional<File> convert(MultipartFile file) throws IOException {
//    	log.info("convert method...");
//    	log.info(file.getOriginalFilename());
//    	File convertFile = new File(file.getOriginalFilename());
//    	log.info("file.."+file);
//        if(convertFile.createNewFile()) {
//            try (FileOutputStream fos = new FileOutputStream(convertFile)) {
//                fos.write(file.getBytes());
//            }
//            return Optional.of(convertFile);
//        }
//
//        return Optional.empty();
//    }
    
}
