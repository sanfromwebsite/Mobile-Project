<script setup lang="ts">
defineProps<{
  label: string
  required?: boolean
  options: { label: string, value: string | number }[]
  disabled?: boolean
}>()

const model = defineModel<string | number>()
</script>

<template>
  <div class="relative border border-gray-200 rounded-lg px-4 transition-all h-13 bg-white">
    <label
      class="absolute left-4 transition-all duration-200 pointer-events-none tracking-wider font-bold"
      :class="model !== undefined && model !== ''
        ? 'top-2 text-[10px] text-gray-400'
        : 'top-1/2 -translate-y-1/2 text-[13px] font-bold text-gray-600'
      "
    >
      {{ label }} <span v-if="required" class="text-red-500">*</span>
    </label>
    <select
      v-model="model"
      :disabled="disabled"
      class="w-full h-full text-[13px] text-gray-800 outline-none bg-transparent pt-4 appearance-none cursor-pointer"
      :class="[ disabled ? 'cursor-not-allowed opacity-70' : '' ]"
    >
      <option value="" disabled hidden />
      <option
        v-for="opt in options"
        :key="opt.value"
        :value="opt.value"
      >
        {{ opt.label }}
      </option>
    </select>
    <div v-if="!disabled" class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none mt-2">
      <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
      </svg>
    </div>
  </div>
</template>