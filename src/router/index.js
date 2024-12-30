import Vue from 'vue';
import Router from 'vue-router';
import MedalTable from '../views/MedalTable.vue';
import CountryDetail from '../views/CountryDetail.vue';

Vue.use(Router);

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'MedalTable',
      component: MedalTable
    },
    {
      path: '/country/:id',
      name: 'CountryDetail',
      component: CountryDetail,
      props: true
    },
    {
      path: '/userManage',
      name: 'userManage',
      component: () => import('../views/UserManage.vue'),
      props: true
    },
    {
      path: '/countrieSportManage',
      name: 'countrieSportManage',
      component: () => import('../views/CountrieSportManage.vue'),
      props: true
    },
  ]
});

// 重写 router.push 方法
const originalPush = router.push;
router.push = function push(location, onComplete, onAbort) {
  return originalPush.call(this, location, onComplete, onAbort).catch(err => {
    if (err.name !== 'NavigationDuplicated') {
      console.error(err);
    }
  });
};

router.beforeEach((to, from, next) => {
  console.log(`Navigating from ${from.path} to ${to.path}`);
  if (to.path === '/') {
    next();
  } else if (to.path === from.path) {
    console.log('Same route, navigation blocked');
    return next(false); // 阻止导航
  } else {
    // 继续导航
    next();
  }
});

export default router;
