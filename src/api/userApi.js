import axios from './request.js';
import { urlApi } from './request.js';

// 获项目列表
export function getUsersList(query) {
    return axios({
        url: urlApi + 'users/list',
        method: 'get',
        params: query ? query : {}
    })
}

// 分页获项目列表
export function getUsersPage(query) {
    return axios({
        url: urlApi + 'users/page',
        method: 'get',
        params: query ? query : {}
    })
}

// 获项目明细
export function getUsersDetail(id) {
    return axios({
        url: urlApi + 'users/detail',
        params: { id: id },
        method: 'get'
    })
}

// 新增国家
export function addUsers(data) {
    return axios({
        url: urlApi + 'users/add',
        method: 'post',
        data: data
    })
}

// 删除国家
export function deleteUsers(data) {
    return axios({
        url: urlApi + 'users/delete',
        method: 'post',
        data: data
    })
}

// 编辑国家
export function editUsers(data) {
    return axios({
        url: urlApi + 'users/edit',
        method: 'post',
        data: data
    })
}

