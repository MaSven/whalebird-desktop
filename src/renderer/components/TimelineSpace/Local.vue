<template>
  <div id="local">
    <div class="local-timeline" v-for="message in timeline" v-bind:key="message.id">
      <toot :message="message" v-on:update="updateToot"></toot>
    </div>
    <div class="loading-card" v-loading="lazyLoading">
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import Toot from './Cards/Toot'

export default {
  name: 'local',
  components: { Toot },
  computed: {
    ...mapState({
      timeline: state => state.TimelineSpace.Local.timeline,
      lazyLoading: state => state.TimelineSpace.Local.lazyLoading
    })
  },
  created () {
    const loading = this.$loading({
      lock: true,
      text: 'Loading',
      spinner: 'el-icon-loading',
      background: 'rgba(0, 0, 0, 0.7)'
    })
    this.initialize()
      .then(() => {
        loading.close()
      })
      .catch(() => {
        loading.close()
      })
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy () {
    this.$store.dispatch('TimelineSpace/Local/stopLocalStreaming')
  },
  destroyed () {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    async initialize () {
      try {
        await this.$store.dispatch('TimelineSpace/Local/fetchLocalTimeline')
      } catch (err) {
        this.$message({
          message: 'Could not fetch timeline',
          type: 'error'
        })
      }
      this.$store.dispatch('TimelineSpace/Local/startLocalStreaming')
    },
    updateToot (message) {
      this.$store.commit('TimelineSpace/Local/updateToot', message)
    },
    onScroll (event) {
      if (((document.documentElement.clientHeight + event.target.defaultView.scrollY) >= document.getElementById('local').clientHeight - 10) && !this.lazyloading) {
        this.$store.dispatch('TimelineSpace/Local/lazyFetchTimeline', this.timeline[this.timeline.length - 1])
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.loading-card {
  background-color: #ffffff;
  height: 60px;
}

.loading-card:empty {
  height: 0;
}
</style>
