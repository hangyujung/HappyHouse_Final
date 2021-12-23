<template>
  <body>
    <!-- Page Header-->
    <!-- <header class="masthead">
		<div class="container position-relative px-4 px-lg-5 py-1">
			<div class="row gx-3 gx-lg-5 justify-content-center">
				<div class="col-md-10 col-lg-8 col-xl-7">
					<div class="page-heading">
						<h1>SIGN IN</h1>
					</div>
				</div>
			</div>
		</div>
	</header> -->
    <!-- Main Content-->

    <main class="mb-5" style="margin-top: 300px">
      <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5 justify-content-center">
          <div class="col-md-10 col-lg-8 col-xl-7">
            <div class="mb-3">
              <label for="inputID" class="form-label">ID *</label>
              <input
                type="text"
                class="form-control"
                id="userid"
                v-model="user.userid"
                placeholder="아이디 입력"
              />
            </div>
            <div class="mb-3">
              <label for="inputPassword" class="form-label">Password *</label>
              <input
                type="password"
                class="form-control"
                id="userpwd"
                v-model="user.userpwd"
                placeholder="영문 숫자 포함 6자리 이상 16자리 이하"
                @keyup.enter="confirm"
              />
            </div>
            <!-- <div class="text-danger mb-2">${msg}</div> -->
            <button class="btn btn-primary mr-3" @click="confirm">
              로그인
            </button>
            <button class="btn btn-secondary">
              <router-link to="/user/signup" style="color: white"
                >회원가입</router-link
              >
            </button>
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
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  name: "memberLogin",
  data() {
    return {
      user: {
        userid: null,
        userpwd: null,
      },
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError"]),
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    async confirm() {
      await this.userConfirm(this.user);
      let token = sessionStorage.getItem("access-token");
      if (this.isLogin) {
        await this.getUserInfo(token);
        this.$router.push({ name: "Home" });
      } else {
        console.log(this.user.userid + "실패");
      }
    },
    movePage() {
      this.$router.push({ name: "SignUp" });
    },
  },
};
</script>

<style scoped></style>
