<template>
  <body>
    <!-- Page Header-->
    <header class="masthead">
      <div class="container position-relative px-4 px-lg-5 py-1">
        <div class="row gx-3 gx-lg-5 justify-content-center">
          <div class="col-md-10 col-lg-8 col-xl-7">
            <div class="page-heading">
              <h1>SIGN IN</h1>
            </div>
          </div>
        </div>
      </div>
    </header>
    <!-- Main Content-->
    <main class="mb-5">
      <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5 justify-content-center">
          <div class="col-md-10 col-lg-8 col-xl-7">
            <div class="mb-3">
              <label for="inputID" class="form-label">ID *</label>
              <input
                type="text"
                class="form-control"
                id="userid"
                v-model="user.userId"
                name="userid"
                placeholder="아이디 입력"
              />
            </div>
            <div class="mb-3">
              <label for="inputPassword" class="form-label">Password *</label>
              <input
                type="password"
                class="form-control"
                id="userpwd"
                v-model="user.password"
                name="userpwd"
                placeholder="영문 숫자 포함 6자리 이상 16자리 이하"
              />
            </div>
            <!-- <div class="text-danger mb-2">${msg}</div> -->
            <button class="btn btn-primary" @click="login">SignIn</button>
            <button type="reset" class="btn btn-secondary">Reset</button>
          </div>
        </div>
      </div>
    </main>
  </body>
</template>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${root}/user/js/scripts.js"></script>

<script>
import axios from "axios";

export default {
  data() {
    return {
      user: {
        userId: "",
        password: "",
      },
    };
  },

  methods: {
    login() {
      axios
        .post("http://localhost:8093/user/login", {
          userId: this.user.userId,
          password: this.user.password,
        })
        .then(({ data }) => {
          console.log(data, "로그인RESPONSE");
        });
    },
  },
};
</script>

<style scoped></style>
