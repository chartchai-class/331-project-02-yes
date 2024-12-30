<template>
  <div class="sports-table-container">
    <h2>Sports Participated In <el-link type="danger" style="margin-left: 40px;" v-if="currentUserId && userType === '0'" @click="goToCountrySportManage()">Edit Countries AND Sports</el-link></h2>
    <div class="table-container">
      <div class="table-wrapper">
        <el-table border :data="sportsData">
          <el-table-column prop="sportName" label="Sport Name" align="center"></el-table-column>
          <el-table-column label="Gold Medals" align="center">
            <template slot-scope="scope">
              <div class="medal-cell">
                <img src="@/assets/gold-medal.png" alt="Gold Medal" class="medal-icon" />
                <span class="medal-text">{{ scope.row.gold }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="Silver Medals" align="center">
            <template slot-scope="scope">
              <div class="medal-cell">
                <img src="@/assets/silver-medal.png" alt="Silver Medal" class="medal-icon" />
                <span class="medal-text">{{ scope.row.silver }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="Bronze Medals" align="center">
            <template slot-scope="scope">
              <div class="medal-cell">
                <img src="@/assets/bronze-medal.png" alt="Bronze Medal" class="medal-icon" />
                <span class="medal-text">{{ scope.row.bronze }}</span>
              </div>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination
            layout="prev, pager, next"
            :total="totalSports"
            :page-size="pageSize"
            v-model="localCurrentPage"
            @current-change="handlePageChange"
        ></el-pagination>
      </div>
    </div>
  </div>
</template>

<script>

import {getSportsPage} from "@/api/sportsApi";

export default {
  props: {
    countryId: {
      Number,
      required: true
    }
  },
  data() {
    return {
      sportsData: [], // 存储体育项目数据
      pageSize: 10,   // 每页显示的体育项目数量
      localCurrentPage: 1, // 当前页码
      totalSports: 0,  // 总体育项目数量
      currentUserId: localStorage.getItem('userId'),
      userType: localStorage.getItem('userType')
    };
  },
  computed: {

  },
  methods: {
    async fetchSportsPage() {
      try {
        getSportsPage({
          pageSize: this.pageSize,
          pageNum: this.localCurrentPage,
          countryId: this.countryId
        }).then(response => {
          this.sportsData = response.result.records;
          this.totalSports = response.result.total;
        }).catch(error => {
          console.log(error);
        })
      } catch (error) {
        console.error('Error fetching sports data:', error);
      }
    },
    handlePageChange(page) {
      this.localCurrentPage = page;
      this.fetchSportsPage(); // 当页面改变时重新获取数据
    },
    goToCountrySportManage() {
      this.$router.push({ name: 'countrieSportManage', params: { countryId: this.countryId } });
    }
  },
  watch: {
    countryId(newCountryId) {
      console.log('Country ID changed:', newCountryId);
      this.localCurrentPage = 1; // 重置页码
      this.fetchSportsPage(); // 重新获取数据
    }
  },
  mounted() {
    this.fetchSportsPage(); // 初始化时获取第一页数据
  }
};
</script>

<style scoped lang="scss">
.sports-table-container {
  text-align: center;
}

.table-container {
  margin-top: 20px;
  display: flex;
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
}

.table-wrapper {
  width: 80%; /* 调整表格宽度 */
  margin: 0 auto; /* 表格居中 */
  text-align: center; /* 确保表格内容居中对齐 */
}

.el-table {
  width: 100%; /* 确保表格占满 table-wrapper 的宽度 */
  text-align: center;
}

.el-pagination {
  margin-top: 20px;
  text-align: center;
}

.medal-cell {
  display: flex;
  align-items: center; /* 垂直居中 */
  justify-content: center; /* 水平居中 */
}

.medal-icon {
  width: 30px;
  height: 30px;
  margin-right: 5px;
}

.medal-text {
  vertical-align: middle;
}
</style>
