import Vue from 'vue'
import Product from '../components/product.vue'
import axios from 'axios'
import vant from 'vant'
import 'vant/lib/index.css'

const baseUrl = "http://127.0.0.1:3000/"
Vue.prototype.$ajax = axios
Vue.prototype.$host = baseUrl
Vue.use(vant)

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Product)
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})