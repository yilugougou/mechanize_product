// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import Vue from 'vue'
import Product from '../components/product.vue'
import axios from 'axios'
import vant from 'vant'
import 'vant/lib/index.css'


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

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