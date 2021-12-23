<template>
  <div id="app">
    <div id="nav">
      <header-comp />
    </div>

    <router-view />
  </div>
</template>

<script>
import HeaderComp from "@/components/HeaderComp.vue";
export default {
  components: { HeaderComp },
  data() {
    // data:function(){  } 와 같음
    return {};
  },
};
</script>

<style></style>
