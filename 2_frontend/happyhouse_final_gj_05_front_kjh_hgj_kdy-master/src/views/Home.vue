<template>
  <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="../img/house2.jpg" class="d-block w-100" alt="..." />
        <div class="carousel-caption d-none d-md-block">
          <h1>Happy House</h1>
          <h3>국내 최대 아파트 거래 정보 플랫폼</h3>
          <p>Welcome to visit Happy House.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from "axios";

export default {
  name: "Home",
  components: {},
  created() {
    axios.get("http://localhost:8093/open/elec").then(({ data }) => {
      console.log(data, "전기차 데이터 내려받음!!");
      // for(let sido of data){
      //   this.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      // }
    });
    axios.get("http://localhost:8093/open/parking").then(({ data }) => {
      console.log(data, "공용주차장 데이터 내려받음!!");
      // for(let sido of data){
      //   this.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      // }
    });
  },
};
</script>
