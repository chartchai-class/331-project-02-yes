package com.cqa.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqa.mapper.CommentsMapper;
import com.cqa.domain.pojo.Comments;
@Service
public class CommentsService extends ServiceImpl<CommentsMapper, Comments> {

}
