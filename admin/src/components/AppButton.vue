<script setup lang="ts">
interface Props {
  type?: 'button' | 'submit' | 'reset'
  variant?: 'primary' | 'secondary'
  disabled?: boolean
  loading?: boolean
  icon?: any
}

const props = withDefaults(defineProps<Props>(), {
  type: 'button',
  variant: 'primary',
  disabled: false,
  loading: false,
})

const emit = defineEmits(['click'])

const handleClick = (event: MouseEvent) => {
  if (props.disabled || props.loading) return
  emit('click', event)
}
</script>

<template>
  <button
    :type="type"
    @click="handleClick"
    :disabled="disabled || loading"
    class="flex items-center justify-center gap-2 px-6 py-2 rounded-lg text-sm font-semibold transition-all shadow-sm active:scale-[0.98] cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed disabled:active:scale-100"
    :class="[
      variant === 'primary' ? 'bg-green-600 hover:bg-green-700 text-white shadow-green-200' : '',
      variant === 'secondary' ? 'border border-gray-100 text-gray-500 hover:bg-gray-50 hover:border-gray-300 shadow-none px-5' : '',
    ]"
  >
    <component :is="icon" v-if="icon && !loading" class="w-4 h-4" />
    <span v-if="loading" class="w-4 h-4 border-2 border-white/20 border-t-white rounded-full animate-spin" />
    <slot v-else />
  </button>
</template>
