import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

import memberStore from "@/store/memberStore.js";

export default new Vuex.Store({
  modules: {
    memberStore,
  },
  plugins: [
    createPersistedState({
      memberStore,
    }),
  ],
});
