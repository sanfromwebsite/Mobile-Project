<script setup>
import { ref } from 'vue'
import { Plus, Eye, SquarePen, Trash2, Shield } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
import AppTable from '@/components/AppTable.vue'
import AppDeleteDialog from '@/components/AppDeleteDialog.vue'
import AppButton from '@/components/AppButton.vue'

const router = useRouter()

const selectedRows = ref([])

const tabs = ['Roles Management', 'Users Management']

const columns = [
  { key: 'name', label: 'Name' },
  { key: 'permission', label: 'Permission' },
  { key: 'status', label: 'Status' },
  { key: 'action', label: 'Action', align: 'right' },
]

const users = ref([
  { id: 1, name: 'Super Admin', permission: 127, status: 'ACTIVE' },
  { id: 2, name: 'Admin',       permission: 34,  status: 'INACTIVE' },
  { id: 3, name: 'Super Admin', permission: 127, status: 'ACTIVE' },
  { id: 4, name: 'Admin',       permission: 127, status: 'ACTIVE' },
  { id: 5, name: 'Super Admin', permission: 127, status: 'ACTIVE' },
  { id: 6, name: 'Admin',       permission: 127, status: 'INACTIVE' },
  { id: 7, name: 'Super Admin', permission: 127, status: 'INACTIVE' },
])

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
</script>

<template>
  <div class="min-h-screen bg-gray-50">
    <p class="text-xs text-gray-400 pb-5 tracking-wide uppercase font-medium">
      Category <span class="px-1 text-gray-300">/</span> List
    </p>

    <div class="flex items-center justify-between pb-6">
      <div class="flex items-center gap-4">
        <div class="w-14 h-14 bg-primary-light rounded-2xl flex items-center justify-center border border-green-200">
          <Shield class="w-7 h-7 text-primary" />
        </div>
        <div>
          <h1 class="text-xl font-bold text-gray-800 leading-tight">Orders</h1>
          <p class="text-xs text-gray-400 pt-0.5">{{ new Date().toLocaleDateString('en-GB', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' }) }}</p>
        </div>
      </div>
      <AppButton
        @click="router.push({ name: 'roles-create' })"
        :icon="Plus"
      >
        Add New
      </AppButton>
    </div>

    <AppTable
      :columns="columns"
      :data="users"
      :tabs="tabs"
      :total-items="20"
      :total-pages="20"
      v-model="selectedRows"
      @search="onSearch"
      @tab-change="onTabChange"
      @page-change="onPageChange"
      @per-page-change="onPerPageChange"
    >
      <template #cell-name="{ row }">
        <div class="flex items-center gap-3">
          <span class="text-sm font-semibold text-gray-700">{{ row.name }}</span>
        </div>
      </template>
      <template #cell-permission="{ row }">
        <span class="text-xs text-black font-bold">
          {{ row.permission }}
        </span>
      </template>

   <template #cell-status="{ row }">
  <div
    class="inline-flex items-center justify-center w-25 px-3 py-1 rounded-lg"
    :class="row.status === 'ACTIVE'
      ? 'bg-green-100 text-green-700'
      : 'bg-red-100 text-red-500'"
  >
    <span class="text-xs font-semibold">
      {{ row.status }}
    </span>
  </div>
</template>

      <template #cell-action="{ row }">
        <div class="flex items-center justify-end gap-2">
          <button
            @click="onView(row)"
            class="text-green-600 cursor-pointer"
            title="View"
          >
            <Eye class="w-4 h-4" />
          </button>
          <button
            @click="onEdit(row)"
            class="text-amber-500 cursor-pointer"
            title="Edit"
          >
            <SquarePen class="w-4 h-4" />
          </button>
          <button
            @click="onDelete(row)"  
            class="text-red-500 cursor-pointer"
            title="Delete"
          >
            <Trash2 class="w-4 h-4" />
          </button>
        </div>
      </template>
    </AppTable>

    <!-- Delete Confirmation -->
    <AppDeleteDialog
      :show="showDeleteDialog"
      :item-name="deleteTarget?.name"
      :loading="deleteLoading"
      message="Are you sure you want to delete this role? This action cannot be undone."
      @confirm="confirmDelete"
      @cancel="cancelDelete"
    />
  </div>
</template>