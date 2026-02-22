<script setup>
import { ref } from 'vue'
import { Plus, Eye, SquarePen, Trash2, Shield } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
import AppButton from '@/components/AppButton.vue'

const router = useRouter()

const selectedRows = ref([])

const tabs = ['Roles Management', 'Users Management']

const onSearch = (query) => {
  console.log('Search:', query)
}

const onTabChange = (tab) => {
  console.log('Tab:', tab)
}

const onPageChange = (page) => {
  console.log('Page:', page)
}

const onPerPageChange = (val) => {
  console.log('Per page:', val)
}

const onView = (user) => {
  router.push({ name: 'roles-view', params: { id: user.id } })
}

const onEdit = (user) => {
  router.push({ name: 'roles-edit', params: { id: user.id } })
}

const showDeleteDialog = ref(false)
const deleteTarget = ref(null)
const deleteLoading = ref(false)

const onDelete = (user) => {
  deleteTarget.value = user
  showDeleteDialog.value = true
}

const confirmDelete = () => {
  deleteLoading.value = true
  setTimeout(() => {
    users.value = users.value.filter(u => u.id !== deleteTarget.value.id)
    deleteLoading.value = false
    showDeleteDialog.value = false
    deleteTarget.value = null
  }, 600)
}

const cancelDelete = () => {
  showDeleteDialog.value = false
  deleteTarget.value = null
}

const search = ref('')

const cards = ref([
  { id: 1, courier: 'VET Express', logo: 'VET', logoColor: '#F5A623', date: '12 Jan, 2025', name: 'Linh Sokheng', phone: '012-435-665', branch: 'សាខា ប្រាយម័ន', address: 'ភ្នំពេញ, ខណ្ឌព្រែកព្នៅ', active: true },
  { id: 2, courier: 'J&T Express', logo: 'J&T', logoColor: '#E8192C', date: '12 Jan, 2025', name: 'Linh Sokheng', phone: '012-435-665', branch: 'សាខា ប្រាយម័ន', address: 'ភ្នំពេញ, ខណ្ឌព្រែកព្នៅ', active: false },
  { id: 3, courier: 'VET Express', logo: 'VET', logoColor: '#F5A623', date: '12 Jan, 2025', name: 'Linh Sokheng', phone: '012-435-665', branch: 'សាខា ប្រាយម័ន', address: 'ភ្នំពេញ, ខណ្ឌព្រែកព្នៅ', active: false },
  { id: 4, courier: 'VET Express', logo: 'VET', logoColor: '#F5A623', date: '12 Jan, 2025', name: 'Linh Sokheng', phone: '012-435-665', branch: 'សាខា ប្រាយម័ន', address: 'ភ្នំពេញ, ខណ្ឌព្រែកព្នៅ', active: false },
])

const paymentMethods = ref([
  {
    id: 1,
    bank: 'ABA BANK',
    date: '12 Jan, 2025',
    initials: 'ABA',
    color: '#1B4F9B',
    type: 'Bank Transfer',
    accMasked: '0003........768',
    accountName: 'Novel Store',
    status: 'Paid',
    hasQr: true,
    avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
  },
  {
    id: 2,
    bank: 'ACLEDA BANK',
    date: '12 Jan, 2025',
    initials: '🦅',
    color: '#F5C518',
    type: 'Bank Transfer',
    accMasked: '0003........768',
    accountName: 'Novel Store',
    status: 'Paid',
    hasQr: false,
    avatar: 'https://randomuser.me/api/portraits/men/45.jpg',
  },
])
</script>

<template>
  <div class="min-h-screen bg-gray-50">
    <p class="text-xs text-gray-400 pb-5 tracking-wide uppercase font-medium">
      Category <span class="px-1 text-gray-300">/</span> List
    </p>

    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-6">
      <div class="flex items-center gap-4">
        <div class="w-14 h-14 bg-primary-light rounded-2xl flex items-center justify-center border border-green-200">
          <Shield class="w-7 h-7 text-primary" />
        </div>
        <div>
          <h1 class="text-xl font-bold text-gray-800 leading-tight">Delivery & Payment</h1>
          <p class="text-xs text-gray-400 pt-0.5">{{ new Date().toLocaleDateString('en-GB', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' }) }}</p>
        </div>
      </div>
      <AppButton @click="router.push({ name: 'roles-create' })" :icon="Plus">
        Add New
      </AppButton>
    </div>

    <!-- Top Bar -->
    <div class="flex flex-wrap justify-between sm:justify-end items-center gap-2 pb-4">
      <div class="relative w-full sm:w-auto">
        <svg class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z" />
        </svg>
        <input
          v-model="search"
          placeholder="Search..."
          class="pl-9 pr-4 py-2 rounded-lg border border-gray-200 bg-white text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-400 w-full sm:w-52 shadow-sm"
        />
      </div>
      <div class="flex gap-2">
        <button class="flex items-center gap-2 px-3 sm:px-4 py-2 bg-white border border-gray-200 rounded-lg text-sm text-gray-700 hover:bg-gray-50 shadow-sm transition">
          <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 0 0 2-2V9l-5-5H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2z" />
          </svg>
          <span class="hidden sm:inline">Export PDF</span>
        </button>
        <button class="flex items-center gap-2 px-3 sm:px-4 py-2 bg-white border border-gray-200 rounded-lg text-sm text-gray-700 hover:bg-gray-50 shadow-sm transition">
          <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 0 0 2-2V9l-5-5H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2z" />
          </svg>
          <span class="hidden sm:inline">Export Excel</span>
        </button>
      </div>
    </div>

    <!-- Main -->
    <div class="flex flex-col xl:flex-row gap-4">

      <!-- Left: Cards Grid -->
      <div class="flex-1 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 content-start">
        <div
          v-for="card in cards"
          :key="card.id"
          class="bg-white rounded-xl p-4 border-2 transition-all hover:shadow-md"
        >
          <!-- Card Header -->
          <div class="flex items-center gap-3 pb-4">
            <div
              class="w-12 h-12 rounded-lg flex items-center justify-center text-white font-bold text-xs shrink-0"
              :style="{ backgroundColor: card.logoColor }"
            >
              {{ card.logo }}
            </div>
            <div>
              <p class="font-semibold text-gray-800 text-sm">{{ card.courier }}</p>
              <p class="text-xs text-gray-400">{{ card.date }}</p>
            </div>
          </div>

          <!-- Card Info -->
          <div class="space-y-1.5 text-xs pb-4">
            <div class="flex justify-between">
              <span class="text-gray-400">Name</span>
              <span class="text-gray-700 font-medium">{{ card.name }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-gray-400">Phone</span>
              <span class="text-gray-700 font-medium">{{ card.phone }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-gray-400">Branch</span>
              <span class="text-gray-700 font-medium">{{ card.branch }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-gray-400">Address</span>
              <span class="text-gray-700 font-medium text-right max-w-[60%]">{{ card.address }}</span>
            </div>
          </div>

          <!-- Actions -->
          <div class="flex gap-2">
            <button class="flex-1 py-1.5 rounded-lg border border-gray-200 text-gray-600 text-xs font-medium hover:bg-gray-50 transition">
              Deactive
            </button>
            <button class="flex-1 py-1.5 rounded-lg bg-green-700 text-white text-xs font-medium hover:bg-green-800 transition">
              View
            </button>
          </div>
        </div>
      </div>

      <!-- Right: Payment Methods -->
      <div class="w-full xl:w-72 flex flex-col sm:flex-row xl:flex-col gap-3 shrink-0">
        <div
          v-for="payment in paymentMethods"
          :key="payment.id"
          class="bg-white rounded-xl p-4 shadow-sm flex-1 xl:flex-none"
        >
          <p class="text-sm font-semibold text-gray-700 pb-3">Payment method</p>

          <!-- Bank Header -->
          <div class="flex items-center gap-3 pb-3">
            <div
              class="w-12 h-12 rounded-xl flex items-center justify-center text-white font-bold text-xs shrink-0"
              :style="{ backgroundColor: payment.color }"
            >
              {{ payment.initials }}
            </div>
            <div class="flex-1">
              <p class="font-semibold text-gray-800 text-sm">{{ payment.bank }}</p>
              <p class="text-xs text-gray-400">{{ payment.date }}</p>
            </div>
            <img :src="payment.avatar" class="w-10 h-12 rounded-lg object-cover" alt="avatar" />
          </div>

          <!-- Payment Details -->
          <div class="grid grid-cols-2 gap-y-2 text-xs pb-3">
            <div>
              <p class="text-gray-400">Type</p>
              <p class="font-medium text-gray-700">{{ payment.type }}</p>
            </div>
            <div>
              <p class="text-gray-400">Acc-number masked</p>
              <p class="font-medium text-gray-700">{{ payment.accMasked }}</p>
            </div>
            <div>
              <p class="text-gray-400">Account Name</p>
              <p class="font-medium text-gray-700">{{ payment.accountName }}</p>
            </div>
            <div>
              <p class="text-gray-400">Status</p>
              <p class="font-medium text-green-600">{{ payment.status }}</p>
            </div>
          </div>

          <!-- QR Code -->
          <div v-if="payment.hasQr" class="pb-3">
            <div class="w-16 h-16 bg-gray-100 rounded flex items-center justify-center">
              <svg class="w-12 h-12 text-gray-400" viewBox="0 0 100 100" fill="currentColor">
                <rect x="10" y="10" width="30" height="30" rx="3" fill="currentColor" opacity="0.8"/>
                <rect x="60" y="10" width="30" height="30" rx="3" fill="currentColor" opacity="0.8"/>
                <rect x="10" y="60" width="30" height="30" rx="3" fill="currentColor" opacity="0.8"/>
                <rect x="20" y="20" width="10" height="10" fill="white"/>
                <rect x="70" y="20" width="10" height="10" fill="white"/>
                <rect x="20" y="70" width="10" height="10" fill="white"/>
                <rect x="60" y="60" width="8" height="8" fill="currentColor" opacity="0.8"/>
                <rect x="72" y="60" width="8" height="8" fill="currentColor" opacity="0.8"/>
                <rect x="60" y="72" width="8" height="8" fill="currentColor" opacity="0.8"/>
                <rect x="72" y="72" width="8" height="8" fill="currentColor" opacity="0.8"/>
              </svg>
            </div>
          </div>

          <!-- Actions -->
          <div class="flex gap-2">
            <button class="flex-1 py-1.5 rounded-lg border border-gray-200 text-gray-600 text-xs font-medium hover:bg-gray-50 transition">
              View
            </button>
            <button class="flex-1 py-1.5 rounded-lg bg-green-700 text-white text-xs font-medium hover:bg-green-800 transition">
              Edit
            </button>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>