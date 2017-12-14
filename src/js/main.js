import getAjax from './getAjax';
import template from '../temp/body.art'

getAjax(20).then(result => {
    console.log(result.showapi_res_body.newslist
    );
    var data = {list:result.showapi_res_body.newslist}
    document.querySelector('.pubu-body').innerHTML = template(data)
})
 
