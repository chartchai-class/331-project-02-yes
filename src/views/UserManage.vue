<template>
  <div style="background-color: white;">
    <SystemHead></SystemHead>
    <el-breadcrumb separator-icon="el-icon-arrow-right" class="breadcrumb" style="margin-left: 10%;margin-bottom: 50px;">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 查询表单 -->
    <el-form :inline="true" :model="queryForm" class="demo-form-inline">
      <el-form-item label="用户名">
        <el-input v-model="queryForm.userName" clearable placeholder="请输入用户名"></el-input>
      </el-form-item>
      <el-form-item label="创建时间起始">
        <el-date-picker
            v-model="queryForm.queryStartTime"
            type="datetime"
            format="yyyy-MM-dd HH:mm:ss"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="创建时间截止">
        <el-date-picker
            v-model="queryForm.queryEndTime"
            type="datetime"
            format="yyyy-MM-dd HH:mm:ss"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getUsers()">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 用户表格 -->
    <el-table :data="tableData" border style="width: 80%;margin: 0 auto;">
      <el-table-column prop="id" label="ID" />
      <el-table-column prop="userName" label="用户名" />
      <el-table-column prop="type" label="类型" >
        <template slot-scope="scope">
          <span v-if="scope.row.type === '1'">普通用户</span>
          <span v-if="scope.row.type === '0'">管理员</span>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" />
      <el-table-column fixed="right" label="操作" width="240">
        <template slot-scope="scope">
          <div v-if="scope.row.id != loginUserId">
            <el-button type="danger" v-if="scope.row.type === '0'" size="small" @click.prevent="editRow(scope.row,'1')">设置为普通用户</el-button>
            <el-button type="success" v-if="scope.row.type === '1'" size="small" @click.prevent="editRow(scope.row,'0')">设置为管理员</el-button>
            <el-button type="warning" size="small" @click.prevent="deleteRow(scope.row)">删除</el-button>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <div class="horizontalView h50">
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

  </div>
</template>

<script>
import { getUsersPage, deleteUsers, editUsers } from '@/api/userApi.js'
import { Message } from 'element-ui'
import SystemHead from "@/components/SystemHead.vue";

export default {
  components: {SystemHead},
  data() {
    return {
      total: 0,
      queryForm: {
        userName: '',
        pageNum: 1,
        pageSize: 10,
        queryStartTime: '',
        queryEndTime: ''
      },
      tableData: [],
      loginUserId: '',
      loginUserName: '',
      loginUserType: ''
    }
  },

  mounted () {
    this.loginUserId = localStorage.getItem('userId')
    this.loginUserName = localStorage.getItem('userName')
    this.loginUserType = localStorage.getItem('userType')
    console.log(this.loginUserId)
    console.log(typeof this.loginUserType)
    console.log(this.loginUserName)
    this.getUsers()
  },

  methods: {
    getUsers() {
      var me = this
      getUsersPage(me.queryForm).then(response => {
        me.tableData = response.result.records
        me.total = response.result.total
        // 强制刷新表格以确保 v-if 重新计算
        this.$nextTick(() => {
          console.log('Table data updated:', me.tableData);
        });
      }).catch(error => {
        console.log(error)
      })
    },
    handleSizeChange(pageSize) {
      this.queryForm.pageSize = pageSize
      this.getUsers()
    },
    handleCurrentChange(pageNum) {
      this.queryForm.pageNum = pageNum
      this.getUsers()
    },
    deleteRow(row) {
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteUsers(row).then(response => {
          Message({
            message: response.msg,
            type: 'success'
          })
          this.getUsers()
        }).catch(error => {
          Message.error(error.msg)
          console.log(error)
        })
      }).catch(() => {
        Message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    editRow(row, type) {
      var me = this
      editUsers({
        id: row.id,
        type: type
      }).then(response => {
        Message({
          message: response.msg,
          type: 'success'
        })
        me.getUsers()
      }).catch(error => {
        Message.error(error.msg)
        console.log(error)
      })
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
