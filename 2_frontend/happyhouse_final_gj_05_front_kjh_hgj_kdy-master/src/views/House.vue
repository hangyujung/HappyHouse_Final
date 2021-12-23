<template>
  <b-container class="bv-example-row mt-3 text-center" fluid>
    <section id="index_section">
      <!-- map -->
      <div id="map" style="width: 100%; height: 500px"></div>
      <!-- <KakaoMap /> -->
      <div class="card col-sm-12 mt-1" style="min-height: 850px">
        <div class="card-body">
          <div id="condition">
            <!-- search -->

            <label for="sido">시도 :</label>

            <b-form-select
              class="form-select"
              v-model="selectedSido"
              :options="sidos"
              @change="sidoChange"
            ></b-form-select>

            <!-- <select id="sido" v-model="selectedSido" v-on:change="sidoChange" class="form-select">
				  	<option v-for="(sido, index) in sidos" :key="index" :value="sidos.sidoCode">{{sido.sidoName}}</option>
					</select>  -->
            <label for="gugun">구군 :</label>
            <!-- <select id="gugun" class="form-select">
						<option v-for="(gugun, index) in guguns" :key="index" :value="guguns.gugunCode">{{gugun.gugunName}}</option>
					</select> -->
            <b-form-select
              class="form-select"
              v-model="selectedGugun"
              :options="guguns"
              @change="gugunChange"
            ></b-form-select>
            <label for="dong">읍면동 :</label>
            <!-- <select id="dong" class="form-select">
						<option value="0">선택</option>
					</select> -->
            <b-form-select
              class="form-select"
              v-model="selectedDong"
              :options="dongs"
              @change="dongChange"
            ></b-form-select>

            <label for="year">건축년도:</label>
            <!-- <select id="year" v-model = "selectedYear" class="form-select" @change="yearChange">
						<option v-for="(year, index) in years" :key="index" :value="year">{{year}}</option>
					</select> -->

            <b-form-select
              class="form-select"
              v-model="selectedYear"
              :options="years"
              @change="yearChange"
            ></b-form-select>

            <!-- <button type="button" id="aptSearchBtn" class="btn btn-secondary">검색</button> -->

            <!-- <button type="button" id="aptYearSearchBtn" class="btn btn-secondary">검색</button> -->

            <label for="name">아파트명:</label>
            <form id="name">
              <input
                type="text"
                id="aptName"
                name="aptName"
                placeholder="예) 자이"
                v-model="selectedName"
                v-on:keydown.enter.prevent="aptNameSearch"
              />
              <button
                type="button"
                id="aptNameSearchBtn"
                class="btn btn-secondary"
                @click="aptNameSearch"
              >
                검색
              </button>
            </form>

            <!-- <button type="button" id="chargeBtn" class="btn btn-secondary"><i class="fas fa-charging-station"></i></button> -->
          </div>

          <!-- <b-table
            striped
            hover
            :items="apts"
            :fields="fields"
            ref="selectableTable"
            selectable
            select-mode="single"
            class="mt-4"
            style="border: 1px solid black"
            @row-selected="onRowSelected"
          >
            <template #cell(index)="data">
              {{ data.index + 1 }}
            </template>
          </b-table> -->
          <table style="width: 80%; border-collapse: collapse">
            <thead>
              <tr>
                <th>번호</th>
                <th>아파트이름</th>
                <th>주소</th>
                <th>건축연도</th>
                <th>최근거래금액</th>
                <th>관심지역 추가</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(li, index) in apts" :key="index" :li="li">
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
                <td @click="addMark(li.aptCode)" style="cursor: pointer">O</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>

    <b-modal id="bv-modal-apt" size="lg" hide-footer>
      <template #modal-title> 아파트 상세정보 </template>
      <b-container class="bv-example-row">
        <b-row align-v="center">
          <b-col>
            <img :src="detail[0].imgSrc" style="width: 300px; height: 400px" />
          </b-col>

          <b-col>
            <b-table stacked :items="detail" :fields="fields_apt"></b-table>

            <!-- <div class="d-block text-center">
              이름: {{ detail.aptName }} <br />
              건축년도: {{ detail.buildYear }} <br />
              주소 : {{ detail.address }} <br />
              가격 : {{ detail.recentPrice }}
            </div> -->
          </b-col>
        </b-row>
        <b-row align-v="center">
          <div class="small">
            <line-chart
              :chart-data="datacollection_apt"
              :width="100"
              :height="100"
            ></line-chart>
          </div>
        </b-row>
      </b-container>
      <b-button class="mt-3" block @click="$bvModal.hide('bv-modal-apt')"
        >닫기</b-button
      >
    </b-modal>

    <b-modal id="bv-modal-parking" size="lg" hide-footer>
      <template #modal-title> 공용주차장 상세정보 </template>
      <b-container class="bv-example-row">
        <b-row align-v="center">
          <b-col>
            <img
              :src="detail_parking[0].imgSrc"
              style="width: 300px; height: 400px"
            />
          </b-col>

          <b-col>
            <b-table
              stacked
              :items="detail_parking"
              :fields="fields_parking"
            ></b-table>
          </b-col>
        </b-row>
        <b-row align-v="center">
          <div class="small">
            <!-- <line-chart :chart-data="datacollection_parking"></line-chart> -->
          </div>
        </b-row>
      </b-container>

      <b-button class="mt-3" block @click="$bvModal.hide('bv-modal-parking')"
        >닫기</b-button
      >
    </b-modal>

    <b-modal id="bv-modal-elec" size="lg" hide-footer>
      <template #modal-title> 전기차 충전소 상세정보 </template>

      <b-container class="bv-example-row">
        <b-row align-v="center">
          <b-col>
            <img
              :src="detail_parking[0].imgSrc"
              style="width: 300px; height: 400px"
            />
          </b-col>
          <b-col>
            <template>
              <div>
                <b-table
                  stacked
                  :items="detail_elec"
                  :fields="fields_elec"
                ></b-table>
              </div>
            </template>
          </b-col>
        </b-row>
        <b-row align-v="center" height="100">
          <div class="small">
            <!-- <line-chart :chart-data="datacollection_elec" :width="100" :height="100"></line-chart> -->
          </div>
        </b-row>
      </b-container>

      <b-button class="mt-3" block @click="$bvModal.hide('bv-modal-elec')"
        >닫기</b-button
      >
    </b-modal>
  </b-container>
</template>

<script>
// import map from "@/js/map.js"
// let colorArr = ['table-primary','table-success','table-danger'];
// import KakaoMap from "@/components/KakaoMap";
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";
import axios from "axios";
//-----------------------------chart
import LineChart from "@/js/LineChart.js";
//-----------------------------chart-end
var apt_markers = [];
var parking_markers = [];
var elec_markers = [];

export default {
  name: "House",
  components: {
    //chart
    LineChart,
    //chart-end
    // KakaoMap,
  },
  data() {
    return {
      //chart
      datacollection: null,
      //chart-end
      map: null,

      sidos: [{ value: null, text: "선택하세요" }],
      selectedSido: null,
      guguns: [{ value: null, text: "선택하세요" }],
      selectedGugun: null,
      dongs: [{ value: null, text: "선택하세요" }],
      selectedDong: null,
      apts: [],
      years: [{ value: null, text: "선택하세요" }],
      selectedYear: null,
      selectedName: "",
      detail: [
        {
          aptName: "",
          buildYear: "",
          address: "",
          recentPrice: "",
          imgSrc: "",
        },
      ],
      detail_parking: [
        {
          addr: "",
          capacity: "",
          name: "",
          pay: "",
          tel: "",
          weekdaybegin: "",
          weekdayend: "",
          weekendbegin: "",
          weekendend: "",
          imgSrc: "",
        },
      ],
      detail_elec: [
        {
          addr: "",
          parkingFree: "",
          statNm: "",
          busiCall: "",
          useTime: "",
        },
      ],

      fields_apt: [
        {
          key: "aptName",
          label: "이름",
        },
        {
          key: "address",
          label: "주소",
        },
        {
          key: "buildYear",
          label: "건축년도",
        },
        {
          key: "recentPrice",
          label: "거래가격",
        },
      ],
      fields_elec: [
        {
          key: "statNm",
          label: "이름",
        },
        {
          key: "addr",
          label: "주소",
        },
        {
          key: "busiCall",
          label: "전화번호",
        },
        {
          key: "parkingFree",
          label: "무료여부",
        },
        {
          key: "useTime",
          label: "사용가능시간",
        },
      ],
      fields_parking: [
        {
          key: "addr",
          label: "주소",
        },
        {
          key: "capacity",
          label: "수용량",
        },
        {
          key: "name",
          label: "이름",
        },
        {
          key: "pay",
          label: "요금",
        },
        {
          key: "tel",
          label: "전화번호",
        },
        {
          key: "weekdaybegin",
          label: "주중시작시간",
        },
        {
          key: "weekdayend",
          label: "주중마감시간",
        },
        {
          key: "weekendbegin",
          label: "주말시작시간",
        },
        {
          key: "weekendend",
          label: "주말마감시간",
        },
      ],

      parkings: [],
      elecs: [],

      fields: [
        {
          key: "aptCode",
          label: "번호",
        },
        {
          key: "aptName",
          label: "아파트이름",
        },
        {
          key: "buildYear",
          label: "건축연도",
        },
        {
          key: "recentPrice",
          label: "거래금액",
        },
        {
          key: "mark",
          label: "관심지역 추가",
        },
      ],
      sel_dong_total_parking: "",
      sel_dong_total_elec: "",

      userinfo: false,
    };
  },
  created() {
    this.setDateBox();

    axios.get("http://localhost:8093/map/sido").then(({ data }) => {
      // for(let sido of data){
      //   this.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      // }
      this.sidos.push({ value: data[0].sidoCode, text: data[0].sidoName });
    });

    // axios.get('http://localhost:8093/map/sido').then(({data})=>{
    //     this.sidos=data
    // }
    // ).finally(()=>console.log(this.sidos));

    // ,function(data){
    //   console.log(data);
    //   $.each(data, function(index, vo) {
    //     $("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
    //   });
    // }
    // , "json"
    // );
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");

      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=08a002569760a207869b64feae1f4e89&libraries=services";
      document.head.appendChild(script);
    }
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(memberStore, ["addMarkedList"]),
    //chart
    fillData() {
      this.datacollection_elec = {
        labels: ["전기 충전소"],
        datasets: [
          {
            label: "서울시 평균",
            backgroundColor: "#999999",
            data: [0.3], //총 데이터 129만    총 동수 : 425개   // 이중 100개만 추출하여 사이트에서 사용하므로 평균 구할때 100으로 나눠줌
          },
          {
            label: "현재동 현황",
            backgroundColor: "#222288",
            data: [this.elecs.length],
          },
        ],
      };
      this.datacollection_parking = {
        labels: ["공용 주차장"],
        datasets: [
          {
            label: "서울시 평균",
            backgroundColor: "#999999",
            data: [43.5],
          },
          {
            label: "현재동 현황",
            backgroundColor: "#222288",
            data: [this.parkings.length],
          },
        ],
      };
      this.datacollection_apt = {
        labels: ["전기충전소", "공용주차장"],
        datasets: [
          {
            label: "서울시 동평균",
            backgroundColor: "#999999",
            data: [0.3, 43.5], //총 데이터 129만    총 동수 : 425개   // 이중 100개만 추출하여 사이트에서 사용하므로 평균 구할때 100으로 나눠줌
          },
          {
            label: "현재동 현황",
            backgroundColor: "#222288",
            data: [this.elecs.length, this.parkings.length],
          },
        ],
      };
    },
    getRandomInt() {
      return Math.floor(Math.random() * (50 - 5 + 1)) + 5;
    },
    //chart-end
    initMap() {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };
      this.map = new kakao.maps.Map(container, options);
    },
    setDateBox() {
      var dt = new Date();
      var com_year = dt.getFullYear();
      // 발행 뿌려주기

      // 올해 기준으로 -1년부터 +5년을 보여준다.
      for (let y = 1981; y <= com_year - 1; y++) {
        this.years.push({ value: y, text: y });
        // this.years.push=y;
      }
    },

    sidoChange() {
      axios
        .get("http://localhost:8093/map/gugun", {
          params: {
            sido: this.selectedSido,
          },
        })
        .then(({ data }) => {
          this.guguns = [{ value: null, text: "선택하세요" }];
          for (let gugun of data) {
            this.guguns.push({ value: gugun.gugunCode, text: gugun.gugunName });
          }
        });
    },
    gugunChange() {
      axios
        .get("http://localhost:8093/map/dong", {
          params: {
            gugun: this.selectedGugun,
          },
        })
        .then(({ data }) => {
          this.dongs = [{ value: null, text: "선택하세요" }];
          for (let dong of data) {
            this.dongs.push({ value: dong.dongCode, text: dong.dongName });
          }
        });
    },
    dongChange() {
      var sel_gu_text = "";
      this.parkings = [];
      this.elecs = [];

      for (let gu of this.guguns) {
        if (gu.value == this.selectedGugun) {
          sel_gu_text = gu.text;
          // console.log(sel_gu_text);
        }
      }

      axios
        .get("http://localhost:8093/map/apt", {
          params: {
            dong: this.selectedDong,
          },
        })
        .then(({ data }) => {
          this.apts = [];
          for (let apt of data) {
            apt.mark = "O";
            this.apts.push(apt);
          }
          this.displayMarkers(data, "apt");
        });

      axios
        .get("http://localhost:8093/open/parking", {
          params: {
            gu: sel_gu_text.substring(0, sel_gu_text.length - 1),
          },
        })
        .then(({ data }) => {
          var sel_dong_text = "";
          for (let dong of this.dongs) {
            if (dong.value == this.selectedDong) {
              sel_dong_text = dong.text;
              // console.log(sel_gu_text);
            }
          }
          for (let gyu of data.GetParkInfo.row) {
            let temp = gyu.ADDR.split(" ");
            // console.log(temp[1], "temp");
            // console.log(sel_dong_text.trim());

            if (sel_dong_text.trim() == temp[1]) {
              this.parkings.push(gyu);
            }
          }

          console.log(this.parkings, "Parking리스트 데이터");
          this.displayMarkers(this.parkings, "parking");
        });

      axios
        .get("http://localhost:8093/open/elec", {
          params: {},
        })
        .then(({ data }) => {
          var sel_dong_text = "";
          for (let dong of this.dongs) {
            if (dong.value == this.selectedDong) {
              sel_dong_text = dong.text;
              console.log(sel_dong_text);
              break;
            }
          }
          this.goasync(data, sel_dong_text);
        });
    },
    async goasync(data, sel_dong_text) {
      for (let elec of data.items[0].item) {
        await axios
          .get("https://dapi.kakao.com/v2/local/geo/coord2regioncode.json", {
            params: {
              x: elec.lng,
              y: elec.lat,
            },
            headers: {
              Authorization: "KakaoAK " + "ac52ea1f10e986b2fae6d71ade5d835e",
            },
          })
          .then(({ data }) => {
            if (data.documents[0].region_3depth_name == sel_dong_text) {
              console.log(elec, "선택된 동이랑 로컬API 같은 동의 elec");
              this.elecs.push(elec);
            }
          });
      }
      //chart
      this.fillData();
      //chart-end
      console.log(this.elecs, "ELECS리스트 데이터");
      this.displayMarkers(this.elecs, "elec");
    },

    yearChange() {
      axios
        .get("http://localhost:8093/map/year", {
          params: {
            dong: this.selectedDong,
            year: this.selectedYear,
          },
        })
        .then(({ data }) => {
          this.apts = [];
          for (let apt of data) {
            this.apts.push(apt);
          }
          // console.log(this.apts);
          this.displayMarkers(data, "apt");
        });
    },
    aptNameSearch() {
      axios
        .get("http://localhost:8093/map/name", {
          params: {
            word: this.selectedName,
          },
        })
        .then(({ data }) => {
          this.apts = [];
          for (let apt of data) {
            this.apts.push(apt);
          }
          console.log(this.apts);
          this.displayMarkers(data, "apt");
        });
    },
    displayMarkers(places, title) {
      this.removeMarker(title);
      if (places.length == 0) return;

      var fragment = document.createDocumentFragment();
      var bounds = new kakao.maps.LatLngBounds();
      var listStr = "";

      // 지도에 표시되고 있는 마커를 제거합니다

      for (var i = 0; i < places.length; i++) {
        if (title == "parking") {
          places[i].lat = places[i].LAT;
          places[i].lng = places[i].LNG;
        }

        var placePosition = new kakao.maps.LatLng(places[i].lat, places[i].lng);

        var marker = this.addMarker(placePosition, i, title);

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        const that = this;
        (function (marker, title, code, place) {
          kakao.maps.event.addListener(marker, "click", function () {
            if (title == "apt") {
              console.log("apt에 대한 클릭리스너 동작!!");
              that.detail[0].aptName = place.aptName;
              that.detail[0].buildYear = place.buildYear;
              that.detail[0].address =
                place.sidoName +
                " " +
                place.gugunName +
                " " +
                place.dongName +
                " " +
                place.jibun;
              that.detail[0].recentPrice =
                ((parseInt(place.recentPrice.replace(",", "")) * 10000) |
                  this.price) +
                "원";

              let number = place.recentPrice.trim().replace(",", "");
              if (number > 50000)
                that.detail[0].imgSrc = require("../img/apt.png");
              else that.detail[0].imgSrc = require("../img/apt1.png");
              that.$bvModal.show("bv-modal-apt");
            } else if (title == "parking") {
              that.detail_parking[0].addr = place.ADDR;
              that.detail_parking[0].capacity = place.CAPACITY;
              that.detail_parking[0].name =
                place.PARKING_NAME + " (" + place.PAY_NM + ")";
              that.detail_parking[0].pay = place.RATES;
              that.detail_parking[0].tel = place.TEL;
              that.detail_parking[0].weekdaybegin = place.WEEKDAY_BEGIN_TIME;
              that.detail_parking[0].weekdayend = place.WEEKDAY_END_TIME;
              that.detail_parking[0].weekendbegin = place.WEEKEND_BEGIN_TIME;
              that.detail_parking[0].weekendend = place.WEEKEND_END_TIME;

              that.detail_parking[0].imgSrc = require("../img/parking.png");
              that.$bvModal.show("bv-modal-parking");
            } else if (title == "elec") {
              that.detail_elec[0].addr = place.addr;
              that.detail_elec[0].parkingFree = place.parkingFree;
              that.detail_elec[0].statNm = place.statNm;
              that.detail_elec[0].busiCall = place.busiCall;
              that.detail_elec[0].useTime = place.useTime;

              that.detail_parking[0].imgSrc = require("../img/elec.png");
              that.$bvModal.show("bv-modal-elec");
            }
          });
        })(marker, title, places[i].aptCode, places[i]);

        // 마커를 생성하고 지도에 표시합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
      }
      this.map.setBounds(bounds);
    },
    addMarker(position, idx, title) {
      var x = 10;
      var y;
      if (title == "apt") {
        marker = new kakao.maps.Marker({
          map: this.map,
          position: position, // 마커의 위치
        });
      } else {
        if (title == "parking") {
          y = 72;
        } else if (title == "elec") {
          y = 36;
        }
        var imageSrc =
            "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(22, 26), // 마커 이미지의 크기
          imgOptions = {
            spriteSize: new kakao.maps.Size(36, 98), // 스프라이트 이미지의 크기
            spriteOrigin: new kakao.maps.Point(x, y), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          },
          markerImage = new kakao.maps.MarkerImage(
            imageSrc,
            imageSize,
            imgOptions
          ),
          marker = new kakao.maps.Marker({
            map: this.map,
            position: position, // 마커의 위치
            image: markerImage,
          });
      }

      // marker.setMap(this.map); // 지도 위에 마커를 표출합니다
      if (title == "apt") apt_markers.push(marker);
      // 배열에 생성된 마커를 추가합니다
      else if (title == "parking") parking_markers.push(marker);
      else if (title == "elec") elec_markers.push(marker);
      return marker;
    },

    removeMarker(title) {
      if (title == "apt") {
        for (let i = 0; i < apt_markers.length; i++) {
          apt_markers[i].setMap(null);
        }
        apt_markers = [];
      } else if (title == "parking") {
        for (let i = 0; i < parking_markers.length; i++) {
          parking_markers[i].setMap(null);
        }
        parking_markers = [];
      } else if (title == "elec") {
        console.log("ㅉㅉㅉㅉㅉㅉㅉㅉ===========");
        for (let i = 0; i < elec_markers.length; i++) {
          elec_markers[i].setMap(null);
        }
        elec_markers = [];
      }
    },
    addMark(aptCode) {
      let map = new Map();
      map.set("userNo", this.userInfo.userNo);
      map.set("aptCode", aptCode);
      this.addMarkedList(map);
      alert(" 추가 완료!");
      this.$forceUpdate;
    },
  },
  filters: {
    price(value) {
      console.log(value);
      if (!value) return value;
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
};
</script>
<style scoped>
@import "../css/house.css";
@import "../css/apt.css";
table {
  margin: 0 auto;
  width: 80%;
  border-collapse: separate;
  border-spacing: 1px;
  line-height: 1.5;
  border-top: 1px solid black;
  text-align: center;
}
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
.small {
  max-width: 400px;
  margin: 50px auto;
}
</style>
