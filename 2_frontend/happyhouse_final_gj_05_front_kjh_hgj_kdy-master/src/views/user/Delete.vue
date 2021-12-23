<template>
  <body>
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <div class="container">
      <div class="row justify-content-around">
        <div class="col-4">
          <h1>탈퇴하시겠습니까?</h1>
          <br />
          <button class="btn btn-success" @click="deleteId">회원탈퇴</button>
        </div>
      </div>
    </div>
  </body>
</template>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="${root}/user/js/scripts.js"></script>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      userId: null,
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(memberStore, ["deleteUser"]),
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    deleteId() {
      this.userId = this.userInfo.userId;
      this.deleteUser(this.userId);
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      sessionStorage.removeItem("access-token");
      this.$router.push({ name: "Home" });
    },
  },
};
</script>
