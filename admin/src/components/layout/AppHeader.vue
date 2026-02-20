<script setup>
import { ref } from 'vue'
import { Search, Bell } from 'lucide-vue-next'

const searchQuery = ref('')
</script>

<template>
  <header class="h-16 bg-white border-b border-gray-100 flex items-center justify-between px-6">
    
    <div class="flex items-center gap-2 rounded-full px-4 py-2 w-72">
      <Search class="w-4 h-4 text-gray-400 shrink-0" />
      <input
        v-model="searchQuery"
        type="text"
        placeholder="Search..."
        class="bg-transparent text-sm text-gray-600 outline-none w-full placeholder-gray-400"
      />
    </div>

    <div class="flex items-center gap-4">
      <button class="relative p-2 text-gray-400 hover:text-green-600 transition-colors">
        <Bell class="w-5 h-5" />
        <span class="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full"></span>
      </button>

      <div class="flex items-center gap-2 cursor-pointer hover:opacity-80 transition-opacity">
        <img
          src="https://i.pravatar.cc/40"
          alt="avatar"
          class="w-9 h-9 rounded-full object-cover border-2 border-green-100"
        />
        <span class="text-sm font-medium text-gray-700">Linh Sokheng</span>
      </div>

    </div>
  </header>
</template>