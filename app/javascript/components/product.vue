<template>
  <div id="app">
    <div id="container">
      <div class="van-doc-demo-block product-info">
        <div class="van-doc-demo-block__title">标题</div>
        <div class="van-cell-group van-hairline--top-bottom">
          <div class="van-cell van-field">
            <div class="van-cell__value van-cell__value--alone">
              <div class="van-field__body">
                <textarea rows="3" placeholder="请输入产品标题" class="van-field__control" v-model="title"></textarea>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="van-doc-demo-block product-info">
        <div class="van-doc-demo-block__title">颜色</div>
        <div class="van-cell-group van-hairline--top-bottom">
          <div class="van-cell van-field">
            <div class="van-cell__value van-cell__value--alone">
              <div class="van-field__body" v-for="color in product_color">
                <div class="product-value-label">
                  <input type="text" placeholder="请输入产品颜色" v-model="color.name" class="van-field__control"/>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="van-doc-demo-block product-info">
        <div class="van-doc-demo-block__title">尺码</div>
        <div class="van-cell-group van-hairline--top-bottom">
          <div class="van-cell van-field">
            <div class="van-cell__value van-cell__value--alone">
              <div class="van-field__body" v-for="size in size_infos">
                <input type="text" placeholder="请输入尺码" v-model="size.name" class="van-field__control"/>
                <input type="text" placeholder="请输入价格" v-model="size.price" class="van-field__control"/>
                <input type="text" placeholder="请输入库存" v-model="size.count" class="van-field__control"/>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="van-doc-demo-block product-info">
        <div class="van-doc-demo-block__title">产品描述</div>
        <div class="van-cell-group van-hairline--top-bottom">
          <div class="van-cell van-field">
            <div class="van-cell__value van-cell__value--alone">
              <div class="van-field__body" v-for="product in product_info">
                <input type="text" placeholder="请输入产品属性" v-model="product.name" class="van-field__control"/>
                <input type="text" placeholder="请输入产品属性值" v-model="product.value" class="van-field__control"/>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="bottom-bar">
        <van-button type="primary" size="info" @click="save">确定修改</van-button>
      </div>
    </div>
  </div>
</template>

<script>
    export default {
        data: function () {
            return {
                ntitle: "产品信息修改",
                title: "",
                product_color: [{name: ""}, {name: ""}],
                size_infos: [
                    {name: "", price: "", count: ""}
                ],
                product_info: [
                    {name: "", value: ""}
                ]
            }
        },
        created() {
            console.log("This is product info page.")
            this.getProduct()
        },
        methods: {
            save() {
            },
            getProduct() {
                let self = this
                this.$ajax({
                    method: 'get',
                    url: self.$host + 'me_demos/grab'
                }).then(function (resp) {
                    console.log(resp.data.title);
                    self.title = resp.data.title
                    self.product_color = resp.data.product_color
                    self.size_infos = resp.data.size_infos
                    self.product_info = resp.data.product_info
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
  background-color: #f7f8fa;
  margin-bottom: 100px;
}
.bottom-bar .submit-btn {
  width: 100%;
  height: 55px;
  background: red;
  text-align: center;
  line-height: 55px;
  font-size: 16px;
  font-family: PingFang-SC-Medium;
  font-weight: 500;
  color: rgba(255, 255, 255, 1);
}

.bottom-bar {
  width: 100%;
  border-top: 1px solid #F3F3F3;
}
.product-info {
  padding-top: 10px;
}

</style>