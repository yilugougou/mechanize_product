<template>
  <div id="app">
    <Navbar :title="ntitle"></Navbar>
    <div id="container">
      <van-field v-model="title" type="textarea" rows="2" cols="3" placeholder="请输入用户名" label="标题"/>
      <div class="van-cell van-field" v-for="(color, index) in product_color" :id="'productColor_' + index">
        <div class="van-cell__title van-field__label">
          <span v-if="index === 0">颜色</span>
        </div>
        <div class="van-cell__value">
          <div class="van-field__body">
            <input type="text" placeholder="请输入颜色" v-model="color.name"/>
            <span class="multi-span">*</span>
          </div>
        </div>
        <i class="van-icon van-icon-delete van-itag"></i>
      </div>
      <div class="size-info">
          <div class="product-label">尺码：</div>
          <table class="size-info">
            <tr v-for="size in size_infos">
              <td><input type="text" placeholder="请输入尺码" v-model="size.name"/></td>
              <td><input type="number" placeholder="请输入价格" v-model="size.price"/></td>
              <td><input type="number" placeholder="请输入库存" v-model="size.count"/></td>
            </tr>
          </table>
      </div>
      <div class="product-info">
        <div class="product-label">描述信息</div>
        <div class="product-value-info" v-for="product in product_info">
          <div class="product-value-label">
            <input type="text" placeholder="请输入产品属性" v-model="product.name"/>
          </div>
          <div class="product-value-value">
            <input type="text" placeholder="请输入产品属性值" v-model="product.value"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
    import Navbar from '../components/navbar.vue'
    export default {
        data: function () {
            return {
                ntitle: "产品信息修改",
                title: "万圣节儿童服装化装舞会演出服高贵王子衣服国王装披风B-0057批发",
                product_color: [{name: "黄色"}, {name: "蓝色"}],
                size_infos: [
                    {name: "M", price: 56, count: 5094},
                    {name: "L", price: 56, count: 5094},
                    {name: "XL", price: 56, count: 5094},
                    {name: "XXL", price: 56, count: 5094}
                ],
                product_info: [
                    {name: "建议零售价", value: "¥90.00"},
                    {name: "建议零售价", value: "¥90.00"},
                    {name: "建议零售价", value: "¥90.00"},
                    {name: "建议零售价", value: "¥90.00"},
                    {name: "建议零售价", value: "¥90.00"},
                    {name: "建议零售价", value: "¥90.00"}
                ]
            }
        },
        components: {
            Navbar
        },
        created() {
            console.log("This is product info page.")
        },
        methods: {
            getProduct() {
                this.$ajax({
                    method: 'get',
                    url: 'http://127.0.0.1:3000/me_demos/0/grab'
                }).then(function (resp) {
                    console.log(resp.data);
                }).catch(resp => {
                    console.log('请求失败：' + resp.status + ',' + resp.statusText);
                })
            }
        }
    }
</script>

<style scoped>
  #container {
    margin-top: 20px;
    padding: 0px 10px;
  }
  #container input {
    border-left: 2px solid #969799;
  }
  .product-value-info {
    display: inline-flex;
    padding: 5px;
    height: 30px;
    line-height: 30px;
  }
  .product-value-info input{
    width: 90%;
  }
  .product-value-label {
    width: 45%;
    padding-left: 5px;
  }
  .product-value-value {

  }
  .product-info {
    padding: 1px;
  }

  .product-label {
    font-size: 14px;
  }
  .van-field__label {
    width: 80px;
  }

  .van-cell {
    line-height: 25px;
  }

  .van-cell__value {
    color: #323233;
  }

  .size-info tr {
    height: 30px;
    line-height: 30px;
  }

  .size-info {
    padding: 1px;
  }

  .size-info td input {
    width: 90%;
  }

</style>