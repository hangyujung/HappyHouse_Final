import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import House from "../views/House.vue";
import Signup from "../views/user/SignUp.vue";
import Login from "../views/user/Login.vue";
import Delete from "../views/user/Delete.vue";
import List from "../views/user/List.vue";
import Mypage from "../views/user/Mypage.vue";
import Search from "../views/user/Search.vue";
import MarkedArea from "../views/user/MarkedArea.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/house",
    name: "House",
    component: House,
  },
  {
    path: "/user/signup",
    name: "Signup",
    component: Signup,
  },
  {
    path: "/user/login",
    name: "Login",
    component: Login,
  },
  {
    path: "/user/delete",
    name: "Delete",
    component: Delete,
  },
  {
    path: "/user/list",
    name: "List",
    component: List,
  },
  {
    path: "/user/mypage",
    name: "Mypage",
    component: Mypage,
  },
  {
    path: "/user/search",
    name: "Search",
    component: Search,
  },
  {
    path: "/user/markedarea",
    name: "MarkedArea",
    component: MarkedArea,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
