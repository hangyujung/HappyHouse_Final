import jwt_decode from "jwt-decode";
import { login } from "@/api/member.js";

import {
  findById,
  getList,
  signUp,
  updateInfo,
  deleteInfo,
  search,
  getMark,
  deleteMark,
  addMark,
} from "../api/member";

const memberStore = {
  namespaced: true,
  state: {
    isLogin: false,
    isLoginError: false,
    userInfo: null,
    searchRes: "",
    userList: [{ name: null, id: null, pw: null, address: null, phone: null }],
    markedList: [],
  },
  getters: {
    checkUserInfo: function (state) {
      return state.userInfo;
    },
  },
  mutations: {
    SET_IS_LOGIN: (state, isLogin) => {
      state.isLogin = isLogin;
    },
    SET_IS_LOGIN_ERROR: (state, isLoginError) => {
      state.isLoginError = isLoginError;
    },
    SET_USER_INFO: (state, userInfo) => {
      state.isLogin = true;
      state.userInfo = userInfo;
    },
    SET_USER_LIST: (state, userlist) => {
      userlist.forEach((li) => {
        state.userList.push({
          name: li.name,
          id: li.userId,
          pw: li.password,
          address: li.address,
          phone: li.phone,
        });
      });
    },
    SEARCH_USER_INFO: (state, searchRes) => {
      state.searchRes = searchRes;
    },
    SET_MARKED_LIST: (state, markedList) => {
      state.markedList = markedList;
    },
  },
  actions: {
    async userConfirm({ commit }, user) {
      await login(
        user,
        (response) => {
          if (response.data.message === "success") {
            let token = response.data["access-token"];
            commit("SET_IS_LOGIN", true);
            commit("SET_IS_LOGIN_ERROR", false);
            sessionStorage.setItem("access-token", token);
          } else {
            commit("SET_IS_LOGIN", false);
            commit("SET_IS_LOGIN_ERROR", true);
          }
        },
        () => {}
      );
    },
    getUserInfo({ commit }, token) {
      let decode_token = jwt_decode(token);
      console.log(decode_token);
      findById(
        decode_token.userid,
        (response) => {
          if (response.data.message === "success") {
            commit("SET_USER_INFO", response.data.userInfo);
            console.log(response.data.userInfo);
          } else {
            console.log("유저 정보 없음!!");
          }
        },
        (error) => {
          console.log("에러");
        }
      );
    },
    async registUser({ commit }, user) {
      await signUp(user);
    },
    async updateUser({ commit }, user) {
      await updateInfo(
        user,
        (response) => {
          commit("SET_USER_INFO", response.data.userInfo);
        },
        () => {}
      );
    },
    async getUserList({ commit }) {
      await getList(
        ({ data }) => {
          console.log("리스트 데이터" + data);
          commit("SET_USER_LIST", data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    async deleteUser({ commit }, userId) {
      await deleteInfo(userId);
    },
    async searchUserInfo({ commit }, userId) {
      await search(
        userId,
        (response) => {
          commit("SEARCH_USER_INFO", response.data.searchRes);
          console.log(response);
        },
        () => {}
      );
    },
    async getMarkedList({ commit }, userNo) {
      await getMark(
        userNo,
        (response) => {
          commit("SET_MARKED_LIST", response.data.markList);
          console.log("getmarkedlist 실행완료");
        },
        () => {}
      );
    },
    async deleteMarkedList({ commit }, map) {
      await deleteMark(map);
      console.log("deletemarkedlist 실행완료");
    },
    addMarkedList({ commit }, map) {
      addMark(map);
    },
  },
};

export default memberStore;
