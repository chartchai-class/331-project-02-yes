<template>
  <div>
    <div class="header-container">
      <img alt="Vue logo" width="80" height="80" src="@/assets/aly.png">
      <el-link type="primary" v-if="currentUserInfo.userType == '0'" @click="userManage">用户管理</el-link>
      <el-link type="primary" v-if="!currentUserInfo.userId" @click="handledDialogVisible">登录</el-link>
      <el-link type="success" v-if="!currentUserInfo.userId" @click="handledRegisterDialogVisible">注册</el-link>
      <el-link type="primary" v-if="currentUserInfo.userId" @click="logout">退出登录</el-link>
    </div>
    <!-- 登录对话框 -->
    <el-dialog :visible.sync="dialogVisible" title="登录" width="30%">
      <el-form ref="loginFormRef" :model="loginForm" label-width="80px" :rules="loginFormRule">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="loginForm.userName"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="loginForm.password" show-password></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click.prevent="login">登录</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <!-- 注册对话框 -->
    <el-dialog :visible.sync="registerDialogVisible" title="注册" width="30%">
      <el-form ref="registerFormRef" :model="registerForm" label-width="80px" :rules="registerFormRule">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="registerForm.userName"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="registerForm.password" show-password></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="registerForm.confirmPassword" show-password></el-input>
        </el-form-item>
        <el-form-item label="头像" prop="avatar">
          <el-upload
              class="upload-facepic"
              action="#"
              accept=".jpg, .jpeg, .png"
              :multiple="false"
              ref="upload"
              :http-request="uploadFile"
              :limit="1"
              :auto-upload="true"
              :file-list="fileList"
              list-type="picture">
            <el-button size="small" type="primary">点击上传头像图片</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/jpeg/png文件</div>
          </el-upload>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click.prevent="register">注册</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import { UserLogin, UserRegister, LoginOut } from "@/api/systemApi";
import { urlApi } from "@/api/request";
import axios from "axios";

export default {
  name: 'SystemHead',
  data() {
    return {
      dialogVisible: false,
      loginForm: {
        userName: '',
        password: ''
      },
      registerForm: {
        userName: '',
        password: '',
        confirmPassword: '',
        avatar: ''
      },
      registerDialogVisible: false,
      imageUrl: '',
      fileList: [],
      loginFormRule: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ]
      },
      registerFormRule: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请输入确认密码', trigger: 'blur' }
        ],
        avatar: [
          { required: true, message: '请上传头像', trigger: 'blur' }
        ]
      },
      currentUserInfo: {
        userName: '',
        avatar: '',
        userType: '',
        userId: ''
      }
    };
  },
  mounted() {
    this.currentUserInfo.userName = localStorage.getItem('userName');
    this.currentUserInfo.userType = localStorage.getItem('userType');
    this.currentUserInfo.userId = localStorage.getItem('userId');
  },
  methods: {
    login() {
      this.$refs.loginFormRef.validate(valid => {
        if (!valid) {
          return false;
        }
        UserLogin(this.loginForm).then((response) => {
          console.log(response); // 调试返回的数据
          if (response && response.code === 200) {
            this.$message({
              message: '登录成功',
              type: 'success'
            });
            localStorage.setItem('Authorization', response.token);
            localStorage.setItem('userName', response.userName);
            localStorage.setItem('userType', response.userType);
            localStorage.setItem('userId', response.userId);
            this.currentUserInfo = {
              userName: response.userName,
              userType: response.userType,
              userId: response.userId
            }

            this.loginForm.userName = '';
            this.loginForm.password = '';
            this.$refs.loginFormRef.resetFields();
            this.dialogVisible = false;
          } else {
            this.$message({
              message: '登录失败：用户名或密码错误',
              type: 'error'
            });
          }
        }).catch((error) => {
          console.log(error);
          if (error.data && error.data.msg) {
            this.$message.error(error.data.msg);
          } else {
            this.$message.error(error || '系统错误');
          }
        })
      });
    },
    register() {
      this.$refs.registerFormRef.validate(valid => {
        if (!valid) {
          return false;
        }
        if (this.registerForm.password !== this.registerForm.confirmPassword) {
          this.$message.error('两次密码不一致');
          return false;
        }
        const data = {
          userName: this.registerForm.userName,
          password: this.registerForm.password,
          avatar: this.registerForm.avatar
        };
        UserRegister(data).then((response) => {
          if (response && response.result) {
            this.$message({
              message: '注册成功',
              type: 'success'
            });

            this.registerForm.userName = '';
            this.registerForm.password = '';
            this.registerForm.confirmPassword = '';
            this.registerForm.avatar = '';
            this.fileList = [];
            this.$refs.upload.clearFiles();

            this.registerDialogVisible = false;
          } else {
            this.$message({
              message: '注册失败',
              type: 'error'
            });
          }
        }).catch((error) => {
          this.$message.error(error || '系统错误');
        })
      });
    },
    logout() {
      LoginOut().then((response) => {
        if (response && response.result) {
          this.$message({
            message: '退出成功',
            type: 'success'
          });
          localStorage.removeItem('Authorization');
          localStorage.removeItem('userName');
          localStorage.removeItem('userType');
          localStorage.removeItem('userId');
          this.currentUserInfo = {
            userName: '',
            userType: '',
            userId: ''
          }
        }
      });
    },
    handledRegisterDialogVisible() {
      this.registerDialogVisible = true;
    },
    handledDialogVisible() {
      this.dialogVisible = true;
    },
    handleChange(file, fileList) {
      console.log(file, fileList);
      this.fileList.push(file);
    },
    uploadFile(param) {
      let file = param.file;
      let formData = new FormData();
      formData.append("file", file);
      let url = urlApi + 'file/uploadFile';
      axios({
        url: url,
        method: 'post',
        data: formData
      })
          .then(res => {
            if (res.code === 200) {
              this.registerForm.avatar = res.fileName;
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
    },
    userManage() {
      this.$router.push({name:'userManage'});
    }
  },
};
</script>

<style scoped>
.header-container {
  display: flex;
  width: 80%;
  align-items: center; /* 垂直居中对齐 */
  gap: 10px; /* 元素之间的间距 */
  margin: 0 auto;
}
</style>
