import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/login',
      name: 'login',
      component: require('@/components/Login').default
    },
    {
      path: '/authorize',
      name: 'authorize',
      component: require('@/components/Authorize').default
    },
    {
      path: '/',
      name: 'global-header',
      component: require('@/components/GlobalHeader').default,
      children: [
        {
          path: ':id/',
          name: 'timeline-space/',
          component: require('@/components/TimelineSpace').default,
          children: [
            {
              path: 'home',
              name: 'home',
              component: require('@/components/TimelineSpace/Home').default
            },
            {
              path: 'notifications',
              name: 'notifications',
              component: require('@/components/TimelineSpace/Notifications').default
            },
            {
              path: 'favourites',
              name: 'favourites',
              component: require('@/components/TimelineSpace/Favourites').default
            },
            {
              path: 'local',
              name: 'local',
              component: require('@/components/TimelineSpace/Local').default
            },
            {
              path: 'public',
              name: 'public',
              component: require('@/components/TimelineSpace/Public').default
            }
          ]
        }
      ]
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
