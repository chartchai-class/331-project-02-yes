import { createPinia, defineStore } from 'pinia';
import Vue from 'vue';

const pinia = createPinia();

// 定义store
const useCommentStore = defineStore('comments', {
  state: () => ({
    comments: {}
  }),
  actions: {
    addComment(countryId, comment) {
      if (!this.comments[countryId]) {
        this.comments[countryId] = [];
      }
      this.comments[countryId].push(comment);
    },
    getComments(countryId) {
      return this.comments[countryId] || [];
    }
  }
});

Vue.use(pinia);

export default pinia;
export { useCommentStore };