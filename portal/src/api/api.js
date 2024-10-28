// 引入 axios
import axios from "axios";



let base = 'http://localhost:8087/api';

//传送json格式的get请求
export const getRequest=(url,params)=>{
    return axios({
        method:'get',
        url:`${base}${url}`,
        data: params,
    })
}
export const getRequestPost=(url,params)=> {
    return axios({
        method: 'post',
        url: `${base}${url}`,
        data: params,
    })
};
