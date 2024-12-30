package com.cqa.controller;

import cn.hutool.core.lang.UUID;
import com.cqa.util.Result;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

/**
 * @version 1.0.0
 * @ClassName FileController.java
 * @Description TODO
 */
@RestController
@RequestMapping("/file")
@Tag(name = "文件接口")
public class FileController {

    @Value("${spring.resources.static-locations}")
    private String locations;

    @PostMapping(value = "/uploadFile")
    public Result uploadFile(@RequestParam Map<String,Object> map, @RequestParam("file") MultipartFile file) throws IOException {

        // 文件名
        String fileName = file.getOriginalFilename();
        // 在file文件夹中创建名为fileName的文件
        assert fileName != null;
        int split = fileName.lastIndexOf(".");
        // 文件后缀，用于判断上传的文件是否是合法的
        String suffix = fileName.substring(split+1,fileName.length());
        //判断文件类型，因为我这边是图片，所以只设置三种合法格式
        String url = "";
        String path = locations.substring(5);
        String newFile = UUID.fastUUID().toString();
        newFile = newFile + "." + suffix;
        if("jpg".equals(suffix) || "jpeg".equals(suffix) || "png".equals(suffix)) {
            // 正确的类型，保存文件
            try {
                File upload = new File(path);
                if(!upload.exists()) {
                    upload.mkdirs();
                }
                File savedFile = new File(path  +"/" +newFile);
                file.transferTo(savedFile);
                url = savedFile.getAbsolutePath();
                System.out.println("图片上传完毕，存储地址为："+"/");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }else {
            //错误的类型，返回错误提示
            return Result.error("文件上传失败,请重试！");
        }

        return Result.ok("文件上传成功").put("fileName","uploadFile/"+newFile);
    }

    /**
     * 获取图片地址
     */
    @RequestMapping(value = "/showImg")
    @ResponseBody
    public void showImg(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String,Object> map) {
        String fileName = map.get("fileName")==null?"":map.get("fileName").toString();
        String path = locations.substring(5);
        File imgFile = new File(path+"/"+fileName);
        FileInputStream fin = null;
        OutputStream output = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition","attachment;fileName="+fileName);
        response.setHeader("Content-type","application/octet-stream");
        try {
            output = response.getOutputStream();
            fin = new FileInputStream(imgFile);
            byte[] arr = new byte[1024 * 10];
            int n;
            while ((n = fin.read(arr)) != -1) {
                output.write(arr, 0, n);
            }
            output.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            output.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
