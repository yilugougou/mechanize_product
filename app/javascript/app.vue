<template>
  <div id="app">
    <h3>标题：</h3>
    <%= title %>
    <h3>颜色：</h3>
      <p v-for="color in product_color">{{color}}</p>
    <h3>尺码：</h3>
      <table>
        <tr v-for="size in size_infos">
          <td><%= size[:name] %></td>
          <td><%= size[:price] %></td>
          <td><%= size[:count] %></td>
        </tr>
      </table>
    <h3>描述信息</h3>

  </div>
</template>

<script>
export default {
  data: function () {
    return {
      title: "万圣节儿童服装化装舞会演出服高贵王子衣服国王装披风B-0057批发",
      product_color: ["黄色", "蓝色"],
      size_infos: [
                {name: "M", price: 56, count: 5094},
                {name: "L", price: 56, count: 5094},
                {name: "XL", price: 56, count: 5094},
                {name: "XXL", price: 56, count: 5094}
                ],
      product_info: []

    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
