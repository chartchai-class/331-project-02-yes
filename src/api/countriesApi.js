import axios from './request.js';
import { urlApi } from './request.js';

// 获取国家列表
export function getCountriesList(query) {
    return axios({
        url: urlApi + 'countries/list',
        method: 'get',
        params: query ? query : {}
    })
}

// 分页获取国家列表
export function getCountriesPage(query) {
    return axios({
        url: urlApi + 'countries/page',
        method: 'get',
        params: query ? query : {}
    })
}

// 获取国家明细
export function getCountriesDetail(id) {
    return axios({
        url: urlApi + 'countries/detail',
        params: { id: id },
        method: 'get'
    })
}

// 新增国家
export function addCountries(data) {
    return axios({
        url: urlApi + 'countries/add',
        method: 'post',
        data: data
    })
}

// 删除国家
export function deleteCountries(data) {
    return axios({
        url: urlApi + 'countries/delete',
        method: 'post',
        data: data
    })
}

// 编辑国家
export function editCountries(data) {
    return axios({
        url: urlApi + 'countries/edit',
        method: 'post',
        data: data
    })
}

