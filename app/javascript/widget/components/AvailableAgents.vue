<template>
  <grouped-avatars :users="users" />
</template>

<script>
import GroupedAvatars from 'widget/components/GroupedAvatars.vue';

export default {
  name: 'AvailableAgents',
  components: { GroupedAvatars },
  props: {
    agents: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    users() {
      if (window.chatwootWebChannel.websiteName.toLowerCase() == 'azaronline') {
        return this.agents.slice(0, 5).map(agent => ({
          id: agent.id,
          avatar: agent.avatar_url,
          name: agent.azar_display_name,
        }));
      }
      if (window.chatwootWebChannel.websiteName.toLowerCase() == 'monovm') {
        return this.agents.slice(0, 5).map(agent => ({
          id: agent.id,
          avatar: agent.avatar_url,
          name: agent.mono_display_name,
        }));
      }
      if (window.chatwootWebChannel.websiteName.toLowerCase() == '1gbits') {
        return this.agents.slice(0, 5).map(agent => ({
          id: agent.id,
          avatar: agent.avatar_url,
          name: agent.gbits_display_name,
        }));
      }
      return this.agents.slice(0, 4).map(agent => ({
        id: agent.id,
        avatar: agent.avatar_url,
        name: agent.name,
      }));
    },
  },
};
</script>
