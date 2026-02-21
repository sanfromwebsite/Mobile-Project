<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ChevronLeft, Copy } from 'lucide-vue-next'
import AppformText from '@/components/form/AppformText.vue'
import AppformSelect from '@/components/form/AppformSelect.vue'
import AppformDate from '@/components/form/AppformDate.vue'
import AppButton from '@/components/AppButton.vue'

const router = useRouter()
const route = useRoute()
const activeTab = ref('General')
const tabs = ['General', 'Business']

const form = ref({
  country: '',
  firstName: '',
  lastName: '',
  username: '',
  gender: '',
  dateOfBirth: '',
  language: '',
  email: '',
  phone: '',
})

const recordId = ref('')

onMounted(() => {
  const id = route.params.id
  recordId.value = `USR0000065${id}`
  const mockData = {
    1: { country: 'CENTRAL', firstName: 'Super', lastName: 'Admin', username: 'superadmin', gender: 'male', dateOfBirth: '1990-01-15', language: 'en', email: 'superadmin@mail.com', phone: '012345678' },
    2: { country: 'CENTRAL', firstName: 'Admin', lastName: 'User', username: 'admin', gender: 'male', dateOfBirth: '1992-05-20', language: 'en', email: 'admin@mail.com', phone: '098765432' },
    3: { country: 'CENTRAL', firstName: 'Super', lastName: 'Admin3', username: 'super3', gender: 'female', dateOfBirth: '1988-11-03', language: 'km', email: 'super3@mail.com', phone: '011222333' },
    4: { country: 'CENTRAL', firstName: 'Admin', lastName: 'User4', username: 'admin4', gender: 'male', dateOfBirth: '1995-07-12', language: 'en', email: 'admin4@mail.com', phone: '044555666' },
    5: { country: 'CENTRAL', firstName: 'Super', lastName: 'Admin5', username: 'super5', gender: 'male', dateOfBirth: '1991-03-25', language: 'en', email: 'super5@mail.com', phone: '077888999' },
    6: { country: 'CENTRAL', firstName: 'Admin', lastName: 'User6', username: 'admin6', gender: 'female', dateOfBirth: '1993-09-08', language: 'km', email: 'admin6@mail.com', phone: '033444555' },
    7: { country: 'CENTRAL', firstName: 'Super', lastName: 'Admin7', username: 'super7', gender: 'male', dateOfBirth: '1987-12-30', language: 'zh', email: 'super7@mail.com', phone: '066777888' },
  }
  if (mockData[id]) {
    form.value = { ...mockData[id] }
  }
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
          Edit
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
          disabled
          :options="[{ label: 'CENTRAL', value: 'CENTRAL' }]"
        />

        <div class="grid grid-cols-2 gap-4">
          <AppformText
            v-model="form.firstName"
            label="First Name"
            disabled
          />
          <AppformText
            v-model="form.lastName"
            label="Last Name"
            disabled
          />
        </div>

        <AppformText
          v-model="form.username"
          label="Username"
          disabled
        />

        <AppformText
          v-model="form.phone"
          label="Phone Number"
          disabled
        />

        <AppformText
          v-model="form.email"
          label="Email Address"
          disabled
        />

        <AppformSelect
          v-model="form.gender"
          label="Gender"
          disabled
          :options="[
            { label: 'Male', value: 'male' },
            { label: 'Female', value: 'female' },
          ]"
        />

        <AppformDate
          v-model="form.dateOfBirth"
          label="Date of Birth"
          disabled
        />

        <AppformSelect
          v-model="form.language"
          label="Language"
          disabled
          :options="[
            { label: 'English', value: 'en' },
            { label: 'Khmer', value: 'km' },
          ]"
        />
      </div>
    </div>
  </div>
</template>