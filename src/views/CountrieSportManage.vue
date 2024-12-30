<template>
  <div style="background-color: white;">
    <SystemHead></SystemHead>
    <el-breadcrumb separator-icon="el-icon-arrow-right" class="breadcrumb" style="margin-left: 10%;margin-bottom: 50px;">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>国家项目管理</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 国家信息编辑表单 -->
    <el-form :model="countryForm" label-width="100px" style="width: 80%;margin: 0 auto;">
      <el-form-item label="国家名称">
        <el-input v-model="countryForm.country" placeholder="请输入国家名称"></el-input>
      </el-form-item>
      <el-form-item label="描述">
        <el-input type="textarea" v-model="countryForm.description" placeholder="请输入描述"></el-input>
      </el-form-item>
      <el-form-item label="图标链接">
        <el-upload
            class="upload-icon"
            action="#"
            accept=".jpg, .jpeg, .png"
            :multiple="false"
            :http-request="uploadIcon"
            :limit="1"
            :auto-upload="true"
            :file-list="iconFileList"
            list-type="picture">
          <el-button size="small" type="primary">点击上传图标图片</el-button>
          <div slot="tip" class="el-upload__tip">
            只能上传一张jpg/jpeg/png文件，请先删除就图片
          </div>
        </el-upload>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="saveCountry()">保存国家信息</el-button>
      </el-form-item>
    </el-form>

    <!-- 添加项目的按钮 -->
    <el-button type="success" @click="showAddSportDialog()" style="margin-top: 20px;">添加项目</el-button>

    <!-- 国家项目列表 -->
    <el-table :data="sportsList" border style="width: 80%;margin: 20px auto;">
      <el-table-column prop="id" label="ID" />
      <el-table-column prop="sportName" label="项目名称" />
      <el-table-column prop="gold" label="金牌数" />
      <el-table-column prop="silver" label="银牌数" />
      <el-table-column prop="bronze" label="铜牌数" />
      <el-table-column fixed="right" label="操作" width="240">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click.prevent="viewSport(scope.row)">详情</el-button>
          <el-button type="danger" size="small" @click.prevent="editSport(scope.row)">编辑</el-button>
          <el-button type="warning" size="small" @click.prevent="deleteSport(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <div class="horizontalView h50" style="width: 80%;margin: 0 auto;">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryForm.pageNum"
          :page-sizes="[10,20,30,40,50]"
          :page-size="queryForm.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
      >
      </el-pagination>
    </div>

    <!-- 添加/编辑体育项目的对话框 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="50%">
      <el-form :model="sportForm" label-width="100px">
        <el-form-item label="项目名称">
          <el-input v-model="sportForm.sportName" placeholder="请输入项目名称"></el-input>
        </el-form-item>
        <el-form-item label="金牌数">
          <el-input-number v-model="sportForm.gold" controls-position="right"></el-input-number>
        </el-form-item>
        <el-form-item label="银牌数">
          <el-input-number v-model="sportForm.silver" controls-position="right"></el-input-number>
        </el-form-item>
        <el-form-item label="铜牌数">
          <el-input-number v-model="sportForm.bronze" controls-position="right"></el-input-number>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveSport()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getCountriesDetail, editCountries } from '@/api/countriesApi.js'
import { getSportsPage, addSports, editSports, deleteSports } from '@/api/sportsApi.js'
import { Message } from 'element-ui'
import SystemHead from "@/components/SystemHead.vue";
import axios from "axios";
import {urlApi} from "@/api/request";

export default {
  components: { SystemHead },
  data() {
    return {
      countryForm: {
        id: null,
        country: '',
        description: '',
        icon: ''
      },
      sportsList: [],
      total: 0,
      queryForm: {
        pageNum: 1,
        pageSize: 10
      },
      sportForm: {
        id: null,
        countryId: this.$route.params.countryId, // 确保在初始化时设置正确的国家ID
        sportName: '',
        gold: null,
        silver: null,
        bronze: null
      },
      dialogVisible: false,
      dialogTitle: '新增项目',
      selectedCountryId: this.$route.params.countryId,
      iconFileList: []
    }
  },

  mounted () {
    console.log(this.$route.params)
    if (!this.$route.params.countryId) {
      this.$router.push('/')
    } else {
      this.loadCountry()
      this.loadSports()
    }

  },

  methods: {
    loadCountry() {
      getCountriesDetail(this.selectedCountryId).then(response => {
        if (response.result) {
          this.setCountry(response.result)
          this.selectedCountryId = response.result.id
          // 回显图标
          if (response.result.icon) {
            this.iconFileList = []
            this.iconFileList.push({
              name: response.result.icon,
              url: response.result.icon
            })
          }
        }
      })
    },
    loadSports() {
      getSportsPage({ countryId: this.selectedCountryId, pageSize: this.queryForm.pageSize, pageNum: this.queryForm.pageNum }).then(response => {
        this.sportsList = response.result.records || []
        this.total = response.result.total || 0
      })
    },
    setCountry(country) {
      Object.assign(this.$data.countryForm, country)
    },
    saveCountry() {
      editCountries(this.countryForm).then(response => {
        Message({
          message: response.msg,
          type: 'success'
        })
        this.loadCountry()
      }).catch(error => {
        Message.error(error.msg)
      })
    },
    showAddSportDialog() {
      // 清空表单并显示添加项目的对话框
      this.resetSportForm()
      this.dialogTitle = "新增项目"
      this.dialogVisible = true
    },
    resetSportForm() {
      this.sportForm = {
        id: null,
        countryId: this.selectedCountryId,
        sportName: '',
        gold: null,
        silver: null,
        bronze: null
      }
    },
    viewSport(sport) {
      Object.assign(this.$data.sportForm, sport)
      this.dialogTitle = "查看项目信息"
      this.dialogVisible = true
    },
    editSport(sport) {
      Object.assign(this.$data.sportForm, sport)
      this.dialogTitle = "编辑项目信息"
      this.dialogVisible = true
    },
    saveSport() {
      if (!this.sportForm.id) {
        // 如果没有ID，则执行添加操作
        this.sportForm.countryId = this.selectedCountryId
        addSports(this.sportForm).then(response => {
          Message({
            message: response.msg,
            type: 'success'
          })
          this.loadSports()
          this.dialogVisible = false
        }).catch(error => {
          Message.error(error.msg)
        })
      } else {
        // 否则执行编辑操作
        editSports(this.sportForm).then(response => {
          Message({
            message: response.msg,
            type: 'success'
          })
          this.loadSports()
          this.dialogVisible = false
        }).catch(error => {
          Message.error(error.msg)
        })
      }
    },
    deleteSport(sport) {
      this.$confirm('此操作将永久删除该项目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteSports({
          id:sport.id
        }).then(response => {
          Message({
            message: response.msg,
            type: 'success'
          })
          this.loadSports()
        }).catch(error => {
          Message.error(error.msg)
        })
      }).catch(() => {
        Message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    handleSizeChange(pageSize) {
      this.queryForm.pageSize = pageSize
      this.loadSports()
    },
    handleCurrentChange(pageNum) {
      this.queryForm.pageNum = pageNum
      this.loadSports()
    },
    uploadIcon(param) {
      let file = param.file;
      let formData = new FormData();
      formData.append("file", file);
      let url = urlApi + 'file/uploadFile'; // 假设你的上传接口是这个
      axios({
        url: url,
        method: 'post',
        data: formData
      })
          .then(res => {
            if (res.code === 200) {
              this.countryForm.icon = res.fileName;
              this.$message({
                message: '文件上传成功',
                type: 'success'
              });
            }
          })
          .catch(error => {
            if (error.data) {
              this.$message.error(error.data.msg);
            } else if (error.response) {
              this.$message.error(error.response.data.msg);
            }
          });
    }
  }
}
</script>

<style scoped>
.horizontalView {
  margin-top: 20px;
  text-align: center;
}

.h50 {
  height: 50px;
}
</style>
