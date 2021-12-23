<template>
  <header>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark">
      <div class="container-fluid">
        <router-link to="/" class="navbar-brand"
          ><img id="logo" src="@/assets/home.png"
        /></router-link>

        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <ul class="navbar-nav me-auto mb-2 mb-md-0">
            <li class="nav-item">
              <router-link to="/house" class="nav-link active"
                >아파트 거래 정보</router-link
              >
            </li>

            <!-- <c:if test="${empty userinfo}"> -->
            <li class="nav-item">
              <div v-if="!userInfo">
                <router-link
                  to="/user/signup"
                  class="nav-link active primary"
                  style="color: $purple"
                  aria-current="page"
                  >회원가입</router-link
                >
              </div>
            </li>
            <li class="nav-item">
              <div v-if="!userInfo">
                <router-link
                  to="/user/login"
                  class="nav-link active"
                  aria-current="page"
                  >로그인</router-link
                >
              </div>
            </li>

            <!-- <c:if test="${!empty userinfo}"> -->
            <li class="nav-item">
              <div v-if="userInfo">
                <span class="nav-link active"
                  >{{ userInfo.name }}님 안녕하세요.</span
                >
              </div>
            </li>
            <li class="nav-item">
              <router-link
                to="/user/mypage"
                v-if="userInfo"
                class="nav-link active"
                >마이페이지</router-link
              >
            </li>
            <li class="nav-item">
              <div
                v-if="userInfo"
                class="nav-link active"
                @click.prevent="onClickLogout"
                style="cursor: pointer"
              >
                로그아웃
              </div>
            </li>
            <li class="nav-item">
              <div v-if="userInfo">
                <router-link
                  to="/user/markedarea"
                  class="nav-link active"
                  aria-current="page"
                  >내 관심지역</router-link
                >
              </div>
            </li>

            <!-- <c:if test="${userinfo.userId eq 'admin' }"> -->
            <li v-if="userInfo" class="nav-item">
              <router-link
                to="/user/search"
                v-if="userInfo.userId === 'admin'"
                class="nav-link active"
                aria-current="page"
                >회원 검색</router-link
              >
            </li>
            <!-- <li v-if="userInfo" class="nav-item">
                    <router-link to="/user/list" v-if="userInfo.userId==='admin'" class="nav-link active" aria-current="page"
                    >회원 목록</router-link
                    >
                </li> -->
          </ul>
          <form class="d-flex">
            <input
              class="form-control me-2"
              type="search"
              placeholder="Search"
              aria-label="Search"
            />
            <button class="btn btn-outline-warning" type="submit">
              Search
            </button>
          </form>
        </div>
      </div>
    </nav>
  </header>
</template>

<script src="/js/location.js"></script>
<script src="/js/map.js"></script>
<script
  src="https://kit.fontawesome.com/b596fe4108.js"
  crossorigin="anonymous"
></script>
<!-- Google Map & Check Box	 -->
<script
  type="application/javascript"
  src="https://zelkun.tistory.com/attachment/cfile8.uf@99BB7A3D5D45C065343307.js"
></script>
<script
  async
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB3orX8_61MJpFJ7vZ6sf5nCqgnJyKWook&callback=initMap&libraries=&v=weekly"
></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
import { mapState, mapMutations } from "vuex";

const memberStore = "memberStore";

export default {
  name: "NaviBar",
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  methods: {
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      console.log("로그아웃");
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      sessionStorage.removeItem("access-token");
      if (this.$route.path != "/") this.$router.push({ name: "Home" });
    },
  },
};
</script>

<style>
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css";
#logo {
  width: 50px;
  height: 70px;
}
</style>
