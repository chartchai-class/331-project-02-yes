/**
 * api接口的统一封装
 */
import axios from './request.js';
import { urlApi } from './request.js';

// 登录
export function UserLogin(query) {
    return axios({
        url: urlApi + 'system/login',
        method: 'post',
        data: query
    })
}

//退出登录
export function LoginOut() {
    return axios({
        url: urlApi + 'system/loginOut',
        method: 'get'
    })
}

// 注册
export function UserRegister(query) {
    return axios({
        url: urlApi + 'system/register',
        method: 'post',
        data: query
    })
}
