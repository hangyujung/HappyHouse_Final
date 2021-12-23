<template>
  <body>
    <!-- Page Header-->
    <!-- <header class="masthead">
		<div class="container position-relative px-4 px-lg-5 py-1">
			<div class="row gx-3 gx-lg-5 justify-content-center">
				<div class="col-md-10 col-lg-8 col-xl-7">
					<div class="page-heading">
						<h1>MY PAGE</h1>
					</div>
				</div>
			</div>
		</div>
	</header> -->
	<!-- Main Content-->
	<main class="mb-5" style="margin-top:200px;">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-md-10 col-lg-8 col-xl-7">
					<div class="mb-3">
						<label for="inputID" class="form-label">ID </label>
						<input readonly="readonly" type="text" class="form-control" id="userid"
							v-bind:value = "userInfo.userId">
					</div>
					<div class="mb-3">
						<label for="inputPW" class="form-label">Password </label>
						<input type="password" class="form-control" id="userpwd" v-model="user.userpwd"
							placeholder="영문 숫자 포함 6자리 이상 16자리 이하">
					</div>
					<div class="mb-3">
						<label for="inputName" class="form-label">Name </label>
						<input type="text" class="form-control" id="username" v-model="user.name"
							>
					</div>
					<div class="mb-3">
						<label for="inputAddress" class="form-label">Address </label>
						<input type="email" class="form-control" id="emailid" v-model="user.address"
							>
					</div>
					<div class="mb-4">
						<label for="inputPhoneNo" class="form-label">Phone Number </label>
						<input type="text" class="form-control" id="phone" v-model="user.phone"
							>
					</div>
					<button class="btn btn-warning mr-3" @click="update">Edit</button>
					<!-- <a href="${root}/user?act=modify&userid=${member.userId}" class="btn btn-warning">Edit</a> -->
					<button class="btn btn-danger"><router-link to="/user/delete" style="color: white;">Delete</router-link></button>
			</div>
		</div>
	</div>
	</main>

	
	
</body>
</template>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="${root}/user/js/scripts.js"></script>

<script>
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      user: {
        userId: null,
        userpwd: null,
        name: null,
        address: null,
        phone: null,
      },
	  curPw: null,
	  curName: null,
	  curAddress: null,
	  curPhone: null,
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(memberStore, ["updateUser"]),
    async update() {
      console.log(this.user);
      this.user.userId = this.userInfo.userId;
      await this.updateUser(this.user);
      alert("변경 완료!");
    },
  },
};
</script>
<style scoped>
@import "../../css/style.css";
</style>
