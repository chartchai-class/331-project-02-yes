<template>
  <div class="centered-container">
    <el-container>
      <el-header style="height: auto; text-align: center;">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item :to="{ path: '/' }">Home</el-breadcrumb-item>
          <el-breadcrumb-item>{{ countryInfo.country }} Country Details</el-breadcrumb-item>
        </el-breadcrumb>
      </el-header>
      <el-main>
        <MedalSummary :countryInfo="countryInfo" />

        <SportsTable
            :countryId="countryId"
        />

        <!-- 使用 CommentsSection 子组件 -->
        <CommentsSection :countryId="countryId" />
      </el-main>
    </el-container>
  </div>
</template>

<script>
import MedalSummary from '../components/MedalSummary.vue'; // 引入 MedalSummary 子组件
import SportsTable from '../components/SportsTable.vue'; // 引入 SportsTable 子组件
import CommentsSection from '../components/CommentsSection.vue';
import {getCountriesDetail} from "@/api/countriesApi"; // 引入 CommentsSection 子组件

export default {
  components: {
    MedalSummary, // 注册 MedalSummary 子组件
    SportsTable, // 注册 SportsTable 子组件
    CommentsSection // 注册 CommentsSection 子组件
  },
  data() {
    return {
      countryId: this.$route.params.countryId,
      countryInfo: {},
      pageSize: 10, // 每页显示的记录数
      currentPage: 1 // 当前页码
    };
  },
  mounted() {
    this.loadCountryInfo();
  },
  methods: {
    async loadCountryInfo() {
      getCountriesDetail(this.countryId).then(response => {
        this.countryInfo = response.result;
        console.log(this.countryInfo);
      }).catch(error => {
        console.error('Error loading country info:', error);
      })
    },
  }
};
</script>

<style scoped>
.centered-container {
  width: 70%;
  margin: 0 auto;
  text-align: center; /* 确保所有内容居中对齐 */
}

h1, h2 {
  text-align: center;
}

p {
  text-align: center;
  margin: 10px 0;
}
.input-group label {
  width: 20%; /* 标签宽度 */
  text-align: right; /* 标签右对齐 */
  margin-right: 10px; /* 标签与输入框之间的间距 */
}

</style>
