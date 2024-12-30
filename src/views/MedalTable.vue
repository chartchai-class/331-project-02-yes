<template>
  <div>
    <SystemHead />
    <el-header>
      <h1>Olympic Medal Standings</h1>
    </el-header>
    <div class="centered-container">
      <el-container>
        <el-main>
          <el-row :gutter="10">
            <el-col :span="6">
              <span>Number of countries per page</span>
            </el-col>
            <el-col :span="12">
              <el-input v-model="pageSize" type="number" placeholder="Number of countries per page">
                <template #append>
                  <el-button type="primary" @click="fetchCountriesPage">Confirm</el-button>
                </template>
              </el-input>
            </el-col>
          </el-row>
          <el-table style="margin-top: 30px" border :data="medals">
            <el-table-column prop="country" label="Country" width="180">
              <template slot-scope="scope">
                <div class="flex-center">
                  <img :src="scope.row.icon" height="30" width="30" alt="Country Flag" />
                  <a href="#" @click.prevent="goToCountryDetail(scope.row.id)">{{ scope.row.country }}</a>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop="gold" label="Gold Medals">
              <template slot-scope="scope">
                <div class="flex-center">
                  <img src="@/assets/gold-medal.png" height="30" width="30" alt="Gold Medal" />
                  <span>{{ scope.row.gold }}</span>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop="silver" label="Silver Medals">
              <template slot-scope="scope">
                <div class="flex-center">
                  <img src="@/assets/silver-medal.png" height="30" width="30" alt="Silver Medal" />
                  <span>{{ scope.row.silver }}</span>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop="bronze" label="Bronze Medals">
              <template slot-scope="scope">
                <div class="flex-center">
                  <img src="@/assets/bronze-medal.png" height="30" width="30" alt="Bronze Medal" />
                  <span>{{ scope.row.bronze }}</span>
                </div>
              </template>
            </el-table-column>
          </el-table>
          <el-pagination
              layout="prev, pager, next"
              :total="totalCountries"
              :page-size="pageSize"
              :current-page.sync="currentPage"
              @current-change="handlePageChange"
          ></el-pagination>
        </el-main>
      </el-container>
    </div>
  </div>
</template>

<script>
import SystemHead from '@/components/SystemHead.vue'
import {getCountriesPage} from '@/api/countriesApi'
export default {
  components: {
    SystemHead
  },
  data() {
    return {
      medals: [],
      pageSize: 10,
      currentPage: 1,
      totalCountries: 0 // 新增字段
    };
  },
  methods: {
    async fetchCountriesPage() {
      getCountriesPage({
        pageSize: this.pageSize,
        pageNum: this.currentPage
      }).then((response) => {
        this.medals = response.result.records;
        this.totalCountries = response.result.total;
      }).catch((error) => {
        console.log(error);
      });
    },
    goToCountryDetail(countryId) {
      console.log(`Going to country detail page for ID: ${countryId}`);
      this.$router.replace({name: 'CountryDetail', params: {countryId: countryId}});
    },
    handlePageChange(page) {
      this.currentPage = page;
      this.fetchCountriesPage(); // 当页面改变时重新获取数据
    }
  },
  created() {
    this.fetchCountriesPage(); // 初始化时获取第一页数据
  }
};
</script>

<style scoped>
.centered-container {
  width: 70%;
  margin: 0 auto;
}

.el-row {
  display: flex;
  align-items: center;
}

.flex-center {
  display: flex;
  align-items: center;
  gap: 8px; /* 图片和文字之间的间距 */
}
</style>
