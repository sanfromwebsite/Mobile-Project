<script setup lang="ts">
import { ref } from 'vue'

defineProps<{
  label: string
  placeholder?: string
  type?: string
  required?: boolean
  disabled?: boolean
}>()

const model = defineModel<string>()
const isFocused = ref(false)
</script>

<template>
  <div 
    class="relative border transition-all duration-200 rounded-lg px-4 h-13 bg-white"
  >
    <label
      class="absolute left-4 transition-all duration-200 pointer-events-none tracking-wider font-bold"
      :class="[
        (model || isFocused)
          ? 'top-2 text-[10px] text-gray-400'
          : 'top-1/2 -translate-y-1/2 text-[13px] font-bold text-gray-600'
      ]"
    >
      {{ label }} <span v-if="required" class="text-red-500">*</span>
    </label>
    
    <input
      v-model="model"
      :type="type ?? 'text'"
      :placeholder="(isFocused && placeholder) ? placeholder : ''"
      :disabled="disabled"
      class="w-full h-full text-[13px] text-gray-800 outline-none bg-transparent font-medium transition-all duration-200"
      :class="[ (model || isFocused) ? 'pt-4' : '', disabled ? 'cursor-not-allowed opacity-70' : '' ]"
      @focus="isFocused = true"
      @blur="isFocused = false"
    />
  </div>
</template>