<template>
<body>
	<!-- Main Content-->
	<main class="mb-5" style="margin-top: 200px;">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-md-10 col-lg-8 col-xl-7">
				<!-- <form id="memberform" class="text-left mb-3" onsubmit="onSubmit"> -->
					<div class="mb-3">
						<label for="inputID" class="form-label">ID *</label> <input
							type="text" class="form-control" id="userid" v-model="user.userId" name="userId"
							placeholder="아이디 입력">
					</div>
					<div class="mb-3">
						<label for="inputPassword" class="form-label">Password *</label> <input
							type="password" class="form-control" id="userpwd" v-model="user.userpwd" name="password"
							placeholder="영문 숫자 포함 6자리 이상 16자리 이하">
					</div>
					<div class="mb-3">
						<label for="inputName" class="form-label">Name *</label> 
						<input type="text" class="form-control" id="username" v-model="user.name" name="name"
							placeholder="이름 입력">
					</div>
					<div class="mb-3">
						<label for="inputImail" class="form-label">Address *</label> <input
							type="email" class="form-control" id="emailid" v-model="user.address" name="address"
							placeholder="이메일주소 입력">
					</div>
					<div class="mb-4">
						<label for="inputPhoneNo" class="form-label">Phone Number *</label>
						 <input type="text" class="form-control" id="phone" v-model="user.phone" name="phone"
							placeholder="010-XXXX-XXXX">
					</div>
					
					<button class="btn btn-primary mr-3" @click="confirm">회원가입</button>
					<!-- <button type="reset" class="btn btn-secondary">Reset</button> -->
				<!-- </form> -->
			</div>
		</div>
	</div>
	</main>
</body>
</template>
<!-- Bootstrap core JS-->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${root}/user/js/scripts.js"></script>

<script>
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  name: "MemberSignUp",
  data() {
    return {
      user: {
        userId: null,
        userpwd: null,
        name: null,
        address: null,
        phone: null,
      },
    };
  },
  computed: {},
  methods: {
    ...mapActions(memberStore, ["registUser"]),
    async confirm() {
      console.log(this.user);
      await this.registUser(this.user);
      this.$router.push({ name: "Login" });
    },
  },
};
</script>

<style scoped>
@import "../../css/style.css";
</style>
