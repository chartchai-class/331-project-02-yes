import axios from './request.js';
import { urlApi } from './request.js';

// 获取评论列表
export function getCommentsList(query) {
    return axios({
        url: urlApi + 'comments/list',
        method: 'get',
        params: query ? query : {}
    })
}


// 新增评论
export function addComments(data) {
    return axios({
        url: urlApi + 'comments/add',
        method: 'post',
        data: data
    })
}


