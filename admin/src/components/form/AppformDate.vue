<script setup lang="ts">
defineProps<{
  label: string
  required?: boolean
}>()

const model = defineModel<string>()
</script>

<template>
  <div class="relative border border-gray-200 rounded-lg px-3.5 transition-all h-13">
    <label
      class="absolute left-3.5 transition-all duration-200 pointer-events-none font-semibold tracking-wider"
      :class="model
        ? 'top-1.5 text-[10px] text-gray-400'
        : 'top-1/2 -translate-y-1/2 text-[13px] text-gray-300'
      "
    >
      {{ label }} <span v-if="required" class="text-red-400">*</span>
    </label>
    <input
      v-model="model"
      type="date"
      class="w-full h-full text-[13px] text-gray-800 outline-none bg-transparent pt-4 appearance-none cursor-pointer"
      :class="!model ? 'text-transparent' : ''"
    />
  </div>
</template>