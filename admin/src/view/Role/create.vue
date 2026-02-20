<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ChevronLeft, Copy, Search, ChevronDown, Eye, EyeOff } from 'lucide-vue-next'
import AppformText from '@/components/form/AppformText.vue'
import AppformSelect from '@/components/form/AppformSelect.vue'
import AppformDate from '@/components/form/AppformDate.vue'
import AppButton from '@/components/AppButton.vue'

const router = useRouter()
const activeTab = ref('General')
const tabs = ['General', 'Business']

const form = ref({
  country: 'CENTRAL',
  firstName: '',
  lastName: '',
  username: '',
  password: '',
  gender: '',
  dateOfBirth: '',
  language: '',
  email: '',
  phone: '855',
})

</script>

<template>
  <div class="min-h-screen bg-white">

    <!-- Top Bar -->
    <div class="flex items-center justify-between px-6 py-4">
      <div class="flex items-center gap-4">
        <button
          @click="router.push({ name: 'roles' })"
          class="p-1.5 hover:bg-gray-100 rounded-lg transition-colors cursor-pointer"
        >
          <ChevronLeft class="w-5 h-5 text-gray-500" />
        </button>
      </div>

      <div class="flex items-center gap-3">
        <AppButton
          variant="secondary"
          @click="router.push({ name: 'roles' })"
        >
          Cancel
        </AppButton>
        <AppButton
          @click="router.push({ name: 'roles' })"
        >
          Create
        </AppButton>
      </div>
    </div>

    <div class="flex gap-1 px-6 border-b border-gray-100">
      <button
        v-for="tab in tabs"
        :key="tab"
        @click="activeTab = tab"
        class="relative px-4 py-3.5 text-sm font-medium transition-all cursor-pointer"
        :class="activeTab === tab
          ? 'text-green-600'
          : 'text-gray-400 hover:text-gray-600'"
      >
        {{ tab }}
        <span
          v-if="activeTab === tab"
          class="absolute bottom-0 left-1 right-1 h-0.5 bg-green-600 rounded-full"
        />
      </button>
    </div>

    <div v-if="activeTab === 'General'" class="px-6 py-6">

      <div class="pb-2">
        <h3 class="text-xs font-semibold text-gray-400 uppercase tracking-wider pb-4">Personal Information</h3>
      </div>

      <div class="grid grid-cols-2 gap-4 pb-6">


        <AppformSelect
          v-model="form.country"
          label="Country"
          required
          :options="[{ label: 'CENTRAL', value: 'CENTRAL' }]"
        />

        <div class="grid grid-cols-2 gap-4">
          <AppformText
            v-model="form.firstName"
            label="First Name"
            placeholder="Enter first name"
            required
          />
          <AppformText
            v-model="form.lastName"
            label="Last Name"
            placeholder="Enter last name"
            required
          />
        </div>

        <AppformText
          v-model="form.username"
          label="Username"
          placeholder="Enter username"
          required
        />

        <AppformText
          v-model="form.phone"
          label="Phone Number"
          placeholder="Enter phone number"
          required
        />

        <AppformText
          v-model="form.email"
          label="Email Address"
          placeholder="Enter email address"
          type="email"
          required
        />

        <AppformSelect
          v-model="form.gender"
          label="Gender"
          required
          :options="[
            { label: 'Male', value: 'male' },
            { label: 'Female', value: 'female' },
          ]"
        />

        <AppformDate
          v-model="form.dateOfBirth"
          label="Date of Birth"
          required
        />

        <AppformSelect
          v-model="form.language"
          label="Language"
          required
          :options="[
            { label: 'English', value: 'en' },
            { label: 'Khmer', value: 'km' },
          ]"
        />
      </div>
    </div>
  </div>
</template>