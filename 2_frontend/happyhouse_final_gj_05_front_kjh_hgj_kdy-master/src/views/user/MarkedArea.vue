<template>
  <body :key="updateHistoriesComponent">
    <section id="index_section">
      <!-- map -->
      <!-- <div id="map" style="width: 100%; height: 500px"></div> -->
      <div class="card col-sm-12 mt-1" style="min-height: 850px">
        <div class="card-body">
          <!-- table -->
          <!-- <table class="table mt-2">
                    <colgroup>
                        <col width="200">
                        <col width="250">
                        <col width="*">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                    </colgroup>	
                    <thead class="tab">
                        <tr>
                            <th>번호</th>
                            <th>아파트이름</th>
                            <th class="text-center">주소</th>
                            <th>건축연도</th>
                            <th>최근거래금액</th>
                            <th>관심지역 삭제</th>
                        </tr>
                    </thead>
                    <tbody id="searchResult" class="tab"></tbody>
                </table>	 -->

          <!-- <b-table striped hover :items="markedList" :fields="fields"
                ref="selectableTable"
                selectable
                class="mt-4"
                style="border:1px solid black"
                @row-selected="onRowSelected">
                <template #cell(index)="data">
                {{ data.index + 1 }}
                </template>
          </b-table> -->

          <!-- <b-table striped hover 
                :items="list"
                :fields="fields">
                </b-table> -->
          <table
            style="
              margin-left: 100px;
              margin-top: 100px;
              width: 80%;
              border-collapse: separate;
              border-spacing: 1px;
              line-height: 1.5;
              border-top: 1px solid black;
              text-align: center;
            "
          >
            <thead>
              <tr>
                <th>번호</th>
                <th>아파트이름</th>
                <th>주소</th>
                <th>건축연도</th>
                <th>최근거래금액</th>
                <th>관심지역 삭제</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(li, index) in list" :key="index" :li="li">
                <td>{{ li.aptCode }}</td>
                <td>{{ li.aptName }}</td>
                <td>
                  {{
                    li.sidoName +
                    " " +
                    li.gugunName +
                    " " +
                    li.dongName +
                    " " +
                    li.jibun
                  }}
                </td>
                <td>{{ li.buildYear }}</td>
                <td>{{ li.recentPrice }}</td>
                <td @click="deleteMark(li.aptCode)" style="cursor: pointer">
                  X
                </td>
              </tr>
            </tbody>
          </table>

          <!-- <b-container v-if="markedList && markedList.length != 0" class="bv-example-row mt-3">
                    <div
                    v-for="(house, index) in houses"
                    :key="index"
                    :house="house">
                    </div>
                </b-container>
                <b-container v-else class="bv-example-row mt-3">
                    <b-row>
                    <b-col><b-alert show>주택 목록이 없습니다.</b-alert></b-col>
                    </b-row>
                </b-container> -->
        </div>
      </div>
    </section>
  </body>
</template>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${root}/user/js/scripts.js"></script>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=08a002569760a207869b64feae1f4e89&libraries=services"
></script>
<script type="text/javascript" src="/js/map.js"></script>
<style scoped>
th {
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
td {
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
</style>
<script>
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      list: [],
      updateHistoriesComponent: 0,
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo", "markedList"]),
  },
  methods: {
    ...mapActions(memberStore, ["getMarkedList", "deleteMarkedList"]),
    async deleteMark(aptCode) {
      let map = new Map();
      map.set("userNo", this.userInfo.userNo);
      map.set("aptCode", aptCode);
      await this.deleteMarkedList(map);
      console.log("딜리트하고 내려옴");
      await this.getMarkedList(this.userInfo.userNo);
      this.list = this.markedList;
      console.log("겟마크드하고 내려옴");
      console.log("총 삭제 완료! 이제 새로고침");
      console.log(this);
      // this.$forceUpdate();
      this.updateHistoriesComponent++;
    },
  },
  async created() {
    await this.getMarkedList(this.userInfo.userNo);
    this.list = this.markedList;
  },
};
</script>
