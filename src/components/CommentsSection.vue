<template>
  <div class="comments-section">
    <h2>Comments</h2>
    <div class="comments-container">
      <el-row :gutter="20">
        <el-col :span="24">
          <div class="input-group">
            <label for="content">Comment:</label>
            <el-input v-model="newCommentContent" id="content" type="textarea" placeholder="Write your comment..." class="narrow-input"></el-input>
          </div>
          <div class="button-container">
            <el-button @click="addComment" class="small-button">Post Comment</el-button>
          </div>
        </el-col>
      </el-row>
      <h2>Comments List</h2>
      <div class="comments-list" ref="commentsList">
        <div v-for="(comment, index) in comments" :key="index" class="comment-item">
          <el-row :gutter="10">
            <el-col :span="4" class="comment-avatar-col">
              <img :src="comment.user.avatar || defaultAvatar" alt="Default Avatar" class="comment-avatar" />
            </el-col>
            <el-col :span="20" class="comment-details-col">
              <div class="comment-author-time">
                <span class="comment-author-label">User Name:</span>
                <span class="comment-author">{{ comment.user.userName }}</span>
                <span class="comment-time-label">Date:</span>
                <span class="comment-time">{{ comment.createTime }}</span>
              </div>
              <p class="comment-content">{{ comment.content }}</p>
            </el-col>
          </el-row>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {getCommentsList,addComments} from "@/api/commentsApi";

export default {
  props: {
    countryId: {
      Number,
      required: true
    }
  },
  data() {
    return {
      newCommentContent: '',
      comments: [],
      defaultAvatar: require('@/assets/default-avatar.png')
    };
  },
  mounted() {
    this.loadComments();
  },
  methods: {
    loadComments() {
      getCommentsList({
        countryId: this.countryId
      }).then(response => {
        this.comments = response.result;
      }).catch(error => {
        console.error('Error loading comments:', error);
      })
      // 显示评论
      this.$nextTick(() => {
        const commentsList = this.$refs.commentsList;
        commentsList.scrollTop = commentsList.scrollHeight;
      });
    },
    addComment() {
      const userId = localStorage.getItem('userId');
      if (!userId) {
        this.$message.error('Please login first');
        return;
      }
      const newComment = {
        userId: userId,
        countryId: this.countryId,
        content: this.newCommentContent,
      };
      if (!newComment.content) {
        this.$message.error('Please enter the comment content');
        return;
      }
      addComments(newComment) .then(response => {
        console.log(response);
        this.newCommentContent = '';
        this.loadComments();
      }).catch(error => {
        console.error('Error adding comment:', error);
      });
    }
  }
};
</script>

<style scoped>
.comments-section {
  margin-top: 20px;
}

h2 {
  text-align: center;
}

p {
  text-align: center;
  margin: 10px 0;
}

.el-row {
  display: flex;
  align-items: center;
}

.input-group {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.input-group label {
  width: 20%; /* 标签宽度 */
  text-align: right; /* 标签右对齐 */
  margin-right: 10px; /* 标签与输入框之间的间距 */
}

.narrow-input {
  width: 60%; /* 缩小宽度到60% */
  margin: 0 auto; /* 居中对齐 */
}

.small-button {
  width: 30%; /* 缩小宽度到30% */
  background-color: #4CAF50; /* 设置背景颜色 */
  color: white; /* 设置文字颜色 */
  margin-top: 10px; /* 设置顶部间距 */
}

.button-container {
  display: flex;
  justify-content: center; /* 按钮水平居中 */
  margin-top: 10px; /* 设置顶部间距 */
}

.comments-container {
  margin-top: 20px;
}

.comments-list {
  border: 1px solid #e0e0e0;
  padding: 10px;
  margin: 20px auto;
  width: 70%;
}

.comment-item {
  border-bottom: 1px solid #e0e0e0;
  padding: 10px 0;
}

.comment-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.comment-avatar-col {
  display: flex;
  align-items: center;
  justify-content: center;
}

.comment-details-col {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.comment-author-time {
  display: flex;
  align-items: center; /* 垂直居中 */
  margin-top: 5px;
}

.comment-author-label {
  font-weight: bold;
  color: #333; /* 姓名颜色 */
  margin-right: 5px;
}

.comment-author {
  font-weight: bold;
  color: #f3a238; /* 姓名标签颜色 */
  margin-right: 10px; /* 评论人和时间之间的间距 */
}

.comment-time-label {
  font-weight: bold;
  color: #333; /* 姓名颜色 */
  margin-right: 5px;
  margin-left: 60px;
}

.comment-time {
  font-size: 0.8em;
  color: #ff9d9d; /* 时间颜色 */
}

.comment-content {
  margin: 10px;
  padding: 0;
  word-break: break-word;
  text-align: left; /* 评论内容靠左对齐 */
  max-height: 100px; /* 设置最大高度 */
  overflow-y: auto; /* 超出部分显示滚动条 */
}
</style>
