package com.test.Urban_Village.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileDownloadController {
private static final String ACCOMMODATION_REPO = "D:\\image\\addImage";
private static final String ACCOMMODATION_REPO1 = "D:\\image\\reviewImage";
    @RequestMapping("/download.do")
    public void download(@RequestParam("imageFileName") String imageFileName,
                         @RequestParam("accommodation_id") String accommodation_id,
                         HttpServletResponse response) throws Exception {
        OutputStream out = response.getOutputStream();
        // 숙소 아이디 폴더 내의 파일 경로 구성
        String downFile = ACCOMMODATION_REPO + "\\" + accommodation_id + "\\" + imageFileName;
        File file = new File(downFile);
        
        // 한글 파일명 처리
        String encodedFileName = URLEncoder.encode(imageFileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
        
        // 캐시 무효화 관련 헤더 
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
        
        FileInputStream in = new FileInputStream(file);
        byte[] buffer = new byte[1024 * 8];
        int count;
        while ((count = in.read(buffer)) != -1) {
            out.write(buffer, 0, count);
        }
        in.close();
        out.close();
    }
    @RequestMapping("/download1.do")
    public void downloadReviewImage(@RequestParam("imageFileName") String imageFileName,
                                    @RequestParam("review_id") String review_id,
                                    HttpServletResponse response) throws Exception {
        OutputStream out = response.getOutputStream();
        // 리뷰 아이디 폴더 내의 파일 경로 구성
        String downFile = ACCOMMODATION_REPO1 + "\\" + review_id + "\\" + imageFileName;
        File file = new File(downFile);
        
        // 한글 파일명 처리
        String encodedFileName = URLEncoder.encode(imageFileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
        
        // 캐시 무효화 관련 헤더 
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
        
        FileInputStream in = new FileInputStream(file);
        byte[] buffer = new byte[1024 * 8];
        int count;
        while ((count = in.read(buffer)) != -1) {
            out.write(buffer, 0, count);
        }
        in.close();
        out.close();
    }
    
   
}

