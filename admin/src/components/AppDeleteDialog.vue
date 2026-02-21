<script setup>
import { Trash2, X } from 'lucide-vue-next'
import AppButton from "@/components/AppButton.vue"

const props = defineProps({
  show: {
    type: Boolean,
    default: false,
  },
  title: {
    type: String,
    default: 'Delete Confirmation',
  },
  message: {
    type: String,
    default: 'Are you sure you want to delete this item? This action cannot be undone.',
  },
  itemName: {
    type: String,
    default: '',
  },
  confirmText: {
    type: String,
    default: 'Delete',
  },
  cancelText: {
    type: String,
    default: 'Cancel',
  },
  loading: {
    type: Boolean,
    default: false,
  },
})

const emit = defineEmits(['confirm', 'cancel'])

const onConfirm = () => {
  if (!props.loading) emit('confirm')
}

const onCancel = () => {
  if (!props.loading) emit('cancel')
}

const onOverlayClick = (e) => {
  if (e.target === e.currentTarget && !props.loading) {
    emit('cancel')
  }
}
</script>

<template>
  <Teleport to="body">
    <Transition name="dialog">
      <div
        v-if="show"
        class="fixed inset-0 z-[999] flex items-center justify-center"
        @click="onOverlayClick"
      >
        <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" />

        <div class="relative bg-white rounded-2xl shadow-2xl w-full max-w-sm mx-4 overflow-hidden animate-dialog-in">
          <div class="px-6 pt-8 pb-6 text-center flex justify-center items-center flex-col">
            <div class="w-16 h-16 mx-auto mb-5 bg-red-50 rounded-full flex items-center justify-center">
              <div class="w-11 h-11 bg-red-100 rounded-full flex items-center justify-center">
                <Trash2 class="w-5 h-5 text-red-500" />
              </div>
            </div>
            <h3 class="text-lg font-bold text-gray-800 pb-4 pt-6">
              {{ title }}
            </h3>
            <p class="text-sm text-gray-400 leading-relaxed mb-1">
              {{ message }}
            </p>
          </div>

          <div class="flex gap-3 px-6 pb-6">
            <AppButton
              @click="onCancel"
              variant="secondary"
            >
              {{ cancelText }}
            </AppButton>
            <AppButton
              @click="onConfirm"
              variant="primary"
            >
              {{ confirmText }}
            </AppButton>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<style scoped>
.dialog-enter-active,
.dialog-leave-active {
  transition: all 0.25s ease;
}

.dialog-enter-from,
.dialog-leave-to {
  opacity: 0;
}

.dialog-enter-from .relative,
.dialog-leave-to .relative {
  transform: scale(0.95) translateY(10px);
}

@keyframes dialog-in {
  from {
    opacity: 0;
    transform: scale(0.95) translateY(10px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.animate-dialog-in {
  animation: dialog-in 0.25s ease-out;
}
</style>
