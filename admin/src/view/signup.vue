<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
    <div class="bg-white rounded-2xl shadow-lg p-10 w-full max-w-md">

      <div class="flex justify-center pb-6">
        <div class="w-16 h-16 rounded-full bg-green-50 flex items-center justify-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-green-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
            <circle cx="8.5" cy="7" r="4" />
            <line x1="20" y1="8" x2="20" y2="14" />
            <line x1="23" y1="11" x2="17" y2="11" />
          </svg>
        </div>
      </div>

      <h1 class="text-2xl font-bold text-center text-gray-900 pb-2">Create Account</h1>
      <p class="text-center text-gray-400 text-sm pb-8">Join us today! Please enter your details.</p>
      <div>
        <div class="pb-4">
          <label class="block text-sm font-semibold text-gray-800 pb-2">
            Full Name <span class="text-red-500">*</span>
          </label>
          <div
            class="flex items-center border rounded-xl px-4 py-3 gap-3 transition-all duration-200"
            :class="focusedField === 'name' ? 'border-green-400 ring-1 ring-green-300' : 'border-gray-200'"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-400 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
            </svg>
            <input
              v-model="form.name"
              type="text"
              placeholder="John Doe"
              class="flex-1 outline-none text-gray-700 text-sm bg-transparent placeholder-gray-300"
              @focus="focusedField = 'name'"
              @blur="focusedField = null"
            />
          </div>
        </div>
        <div class="pb-4">
          <label class="block text-sm font-semibold text-gray-800 pb-2">
            Email Address <span class="text-red-500">*</span>
          </label>
          <div
            class="flex items-center border rounded-xl px-4 py-3 gap-3 transition-all duration-200"
            :class="focusedField === 'email' ? 'border-green-400 ring-1 ring-green-300' : 'border-gray-200'"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-400 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
              <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" />
            </svg>
            <input
              v-model="form.email"
              type="email"
              placeholder="name@example.com"
              class="flex-1 outline-none text-gray-700 text-sm bg-transparent placeholder-gray-300"
              @focus="focusedField = 'email'"
              @blur="focusedField = null"
            />
          </div>
        </div>
        <div class="pb-6">
          <label class="block text-sm font-semibold text-gray-800 pb-2">
            Password <span class="text-red-500">*</span>
          </label>
          <div
            class="flex items-center border rounded-xl px-4 py-3 gap-3 transition-all duration-200"
            :class="focusedField === 'password' ? 'border-green-400 ring-1 ring-green-300' : 'border-gray-200'"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-400 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
              <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 10-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H6.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z" />
            </svg>
            <input
              v-model="form.password"
              :type="showPassword ? 'text' : 'password'"
              placeholder="••••••••"
              class="flex-1 outline-none text-gray-700 text-sm bg-transparent placeholder-gray-300"
              @focus="focusedField = 'password'"
              @blur="focusedField = null"
            />
            <button @click="showPassword = !showPassword" type="button" class="text-gray-400 hover:text-gray-600">
              <svg v-if="!showPassword" xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
              </svg>
              <svg v-else xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.542-7 1.274-4.057 5.064-7 9.542-7 1.247 0 2.447.28 3.523.775M21 21l-6.75-6.75" />
              </svg>
            </button>
          </div>
        </div>
        <div class="pb-6">
          <button
            @click="handleSignup"
            class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-3.5 rounded-xl transition-all duration-200 text-sm tracking-wide shadow-md active:scale-[0.98]"
          >
            Sign Up
          </button>
        </div>
        <div class="text-center">
          <p class="text-gray-400 text-sm pb-1">Already have an account?</p>
          <router-link to="/login" class="text-green-600 text-sm font-semibold hover:text-green-700 transition-colors">
            Sign in here
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const focusedField = ref(null)
const showPassword = ref(false)

const form = reactive({
  name: '',
  email: '',
  password: ''
})

function handleSignup() {
  if (!form.name || !form.email || !form.password) return
  console.log('Signing up with:', form)
  router.push('/login')
}
</script>