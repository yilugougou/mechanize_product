<template>
    <div class="navbar">
      <div class="navbar-left">
        <slot name="left">
          <a class="btn-back" href="javascript:;">
            <i class="iconfont icon-back"></i>
          </a>
        </slot>
      </div>
      <h3 class="navbar-title">{{title}}</h3>
      <div class="navbar-right">
        <slot name="right"></slot>
      </div>
    </div>
</template>

<script>
export default {
  props: ["left", "title", "right", "back"],
}
</script>
<style scoped>
  .navbar-title {
    max-width: 60%;
    font-size: 16px;
    text-align: center;
    margin: 0 auto;
  }

  .navbar-left,
  .navbar-right {
    position: absolute;
    top: 0;
    font-size: 16px;
  }

  .navbar-right {
    right: 0;
  }

  .navbar {
    position: fixed;
    top: 0;
    left: 0;
    display: flex;
    align-items: center;
    width: 100%;
    height: 50px;
    background-color: #fff;
    box-sizing: border-box;
    z-index: 9;
    line-height: 50px;
    border-bottom: 1px solid #efefef;
  }
</style>