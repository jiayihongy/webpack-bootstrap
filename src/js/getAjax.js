import api from './myApi';

function formatterDateTime() {
    var date=new Date()
    var month=date.getMonth() + 1
        var datetime = date.getFullYear()
                + ""// "年"
                + (month >= 10 ? month : "0"+ month)
                + ""// "月"
                + (date.getDate() < 10 ? "0" + date.getDate() : date
                        .getDate())
                + ""
                + (date.getHours() < 10 ? "0" + date.getHours() : date
                        .getHours())
                + ""
                + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date
                        .getMinutes())
                + ""
                + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date
                        .getSeconds());
        return datetime;
    }
 
function getAjax(num){
    return new Promise((resolve,reject)=>{
        $.ajax({
            type: 'post',
            url: api.url,
            dataType: 'jsonp',
            data: {
                "showapi_timestamp": formatterDateTime(),
                 "showapi_appid": api.id, //这里需要改成自己的appid
                 "showapi_sign": api.key,
                 'num':  num,
                 'rand':0
         
            },
            jsonp: 'jsonpcallback', //这个方法名很重要,不能改变
            error: function(XmlHttpRequest, textStatus, errorThrown) {
                reject(textStatus);
            },
            success: function(result) {
                resolve(result);
            }
        });
    })
}

export default getAjax;