import axios from 'axios'

const urlApi = '/api/'; //本地测试

// 请求拦截
axios.interceptors.request.use(
    (config) => {
        //设置请求头
        if (localStorage.getItem('Authorization')) { //判断本地缓存的token是否存在
            config.headers.satoken = localStorage.getItem('Authorization')
        }
        return config
    },
    (error) => { //token不存在，设置为网络报错
        return Promise.reject(error)
    }
)

//响应拦截
axios.interceptors.response.use(
    (res) => { //响应处理
        if (res.status === 200) { //响应码200请求成功

            if (res.data.code === 200) { //接口请求成功
                return Promise.resolve(res.data)
            } else if (res.data.code === '10000' || res.data.code === '10001') { //token验证失败，根据自己实际的修改
            }
            return Promise.reject(res)
        } else {
            return Promise.reject(res)
        }
        // return res
    },
    (error) => {

        // 获取状态码
        const {
            status
        } = error.response || error.code || error.status

        return Promise.reject(error)
    }
)

export default axios

export { urlApi }
