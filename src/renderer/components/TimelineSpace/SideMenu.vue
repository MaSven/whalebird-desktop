<template>
  <div id="side_menu">
    <div class="profile-wrapper" style="-webkit-app-region: drag;">
      <div class="profile">
        <div>@{{ username }}</div>
        <span>{{ account.domain }}</span>
      </div>
    </div>
    <el-menu
      :default-active="$route.path"
      background-color="#373d48"
      text-color="#909399"
      active-text-color="#ffffff"
      :router="true"
      class="el-menu-vertical timeline-menu">
      <el-menu-item :index="`/${id()}/home`">
        <icon name="home"></icon>
        <span>Home</span>
        <el-badge is-dot :hidden="!unreadHomeTimeline">
        </el-badge>
      </el-menu-item>
      <el-menu-item :index="`/${id()}/notifications`">
        <icon name="bell"></icon>
        <span>Notification</span>
        <el-badge is-dot :hidden="!unreadNotifications">
        </el-badge>
      </el-menu-item>
      <el-menu-item :index="`/${id()}/favourites`">
        <icon name="star"></icon>
        <span>Favourite</span>
      </el-menu-item>
      <el-menu-item :index="`/${id()}/local`">
        <icon name="users"></icon>
        <span>LocalTimeline</span>
      </el-menu-item>
      <el-menu-item :index="`/${id()}/public`">
        <icon name="globe"></icon>
        <span>PublicTimeline</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  name: 'side-menu',
  computed: {
    ...mapState({
      account: state => state.TimelineSpace.account,
      username: state => state.TimelineSpace.username,
      unreadHomeTimeline: state => state.TimelineSpace.SideMenu.unreadHomeTimeline,
      unreadNotifications: state => state.TimelineSpace.SideMenu.unreadNotifications
    })
  },
  methods: {
    id () {
      return this.$route.params.id
    }
  }
}
</script>

<style lang="scss" scoped>
#side_menu {
  .profile-wrapper {
    background-color: #373d48;
    position: fixed;
    top: 0;
    left: 65px;
    width: 180px;
    height: 70px;

    .profile {
      color: #ffffff;
      font-weight: bold;
      padding: 20px 8px 10px 20px;
      box-sizing: border-box;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  }

  .timeline-menu /deep/ {
    position: fixed;
    top: 70px;
    left: 65px;
    height: 100%;
    width: 180px;

    .el-badge__content {
      background-color: #409eff;
      border: none;
      margin-left: 4px;
    }
  }
}
</style>
