<template>
  <body>
    <br /><br /><br /><br />
    <div class="mb-3 mt-3">
      <input
        type="text"
        class="form-control"
        name="userid"
        placeholder="ID로 검색"
        v-model="user.userId"
      />
    </div>
    <button class="btn btn-primary" @click="search">검색</button>

    <div class="mb-3">
      <label for="inputName" class="form-label">Password </label>
      <input readonly="readonly" type="text" class="form-control" :value="searchRes.password" />
    </div>
    <div class="mb-3">
      <label for="inputName" class="form-label">Name </label>
      <input
        readonly="readonly"
        type="text"
        class="form-control"
        id="username"
        name="username"
        :value="searchRes.name"
      />
    </div>
    <div class="mb-3">
      <label for="inputAddress" class="form-label">Address </label>
      <input
        readonly="readonly"
        type="email"
        class="form-control"
        id="emailid"
        name="address"
        :value="searchRes.address"
      />
    </div>
    <div class="mb-4">
      <label for="inputPhoneNo" class="form-label">Phone Number </label>
      <input
        readonly="readonly"
        type="text"
        class="form-control"
        id="phone"
        name="phone"
        :value="searchRes.phone"
      />
    </div>
  </body>
</template>

<script>
import { mapActions, mapState } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      user: {
        userId: null,
      },
    };
  },
  mounted() {
    this.search();
  },
  computed: {
    ...mapState(memberStore, ["searchRes"]),
  },
  methods: {
    ...mapActions(memberStore, ["searchUserInfo"]),
    async search() {
      console.log(this.user.userId);
      await this.searchUserInfo(this.user.userId);
    },
  },
};
</script>

<style scoped></style>
