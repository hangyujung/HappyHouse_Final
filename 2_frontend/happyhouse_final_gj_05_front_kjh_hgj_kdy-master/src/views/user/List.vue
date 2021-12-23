<template>
  <body>
    <br /><br /><br /><br />
    <h1>회원 목록</h1>
    <button @click="list">목록 확인</button>
    <ol>
      <!-- <c:forEach var="info" items="${userlist}">
			<li><c:out value="이름: ${info.name} ID: ${info.userId} 비밀번호: ${info.password} 이메일: ${info.address} 휴대폰번호: ${info.phone}"></c:out></li>
		</c:forEach> -->

      <li v-for="(item, index) in userlist" :key="index">
        {{ item }}
      </li>
    </ol>
  </body>
</template>

<script>
import { mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      userlist: [],
    };
  },
  computed: {},
  methods: {
    ...mapActions(memberStore, ["getUserList"]),
    async list() {
      await this.getUserList();
    },
  },
};
</script>

<style scoped></style>
