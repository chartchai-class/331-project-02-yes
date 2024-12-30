import axios from './request.js';
import { urlApi } from './request.js';

// 获项目列表
export function getSportsList(query) {
    return axios({
        url: urlApi + 'sports/list',
        method: 'get',
        params: query ? query : {}
    })
}

// 分页获项目列表
export function getSportsPage(query) {
    return axios({
        url: urlApi + 'sports/page',
        method: 'get',
        params: query ? query : {}
    })
}

// 获项目明细
export function getSportsDetail(id) {
    return axios({
        url: urlApi + 'sports/detail',
        params: { id: id },
        method: 'get'
    })
}

// 新增国家
export function addSports(data) {
    return axios({
        url: urlApi + 'sports/add',
        method: 'post',
        data: data
    })
}

// 删除国家
export function deleteSports(data) {
    return axios({
        url: urlApi + 'sports/delete',
        method: 'post',
        data: data
    })
}

// 编辑国家
export function editSports(data) {
    return axios({
        url: urlApi + 'sports/edit',
        method: 'post',
        data: data
    })
}

