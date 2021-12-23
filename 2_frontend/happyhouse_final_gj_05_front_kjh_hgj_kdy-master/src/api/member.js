import { apiInstance } from "./index.js";
import axios from "axios";

const api = apiInstance();

async function login(user, success, fail) {
  console.log(user);
  await api
    .post(`/user/login`, {
      userId: user.userid,
      password: user.userpwd,
    })
    .then(success)
    .catch(fail);
}

async function findById(userid, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/info/${userid}`).then(success).catch(fail);
}

async function signUp(user, success, fail) {
  await api
    .post(`/user/regist`, {
      userId: user.userId,
      password: user.userpwd,
      name: user.name,
      address: user.address,
      phone: user.phone,
    })
    .then(success)
    .catch(fail);
}

async function updateInfo(user, success, fail) {
  await api
    .put(`/user/update`, {
      userId: user.userId,
      password: user.userpwd,
      name: user.name,
      address: user.address,
      phone: user.phone,
    })
    .then(success)
    .catch(fail);
}

async function getList(success, fail) {
  await api.get(`/user/list`).then(success).catch(fail);
}

async function deleteInfo(userId, success, fail) {
  await api.delete(`/user/delete/${userId}`).then(success).catch(fail);
}

async function search(userId, success, fail) {
  await api.get(`/user/search/${userId}`).then(success).catch(fail);
}

async function getMark(userNo, success, fail) {
  await api.get(`/map/myMark/${userNo}`).then(success).catch(fail);
}

async function deleteMark(map, success, fail) {
  console.log(map);
  console.log(map.get("userNo") + " " + map.get("aptCode"));
  const userNo = map.get("userNo");
  const aptCode = map.get("aptCode");
  await api
    .delete(`/map/deleteMark`, { params: { userNo: userNo, aptCode: aptCode } })
    .then(success)
    .catch(fail);
}

async function addMark(map, success, fail) {
  console.log(map);
  console.log(map.get("userNo") + " " + map.get("aptCode"));
  const userNo = map.get("userNo");
  const aptCode = map.get("aptCode");
  const params = { userNo: userNo, aptCode: aptCode };
  await api.post(`/map/cart`, params).then(success).catch(fail);
}
export {
  login,
  findById,
  signUp,
  getList,
  updateInfo,
  deleteInfo,
  search,
  getMark,
  deleteMark,
  addMark,
};
