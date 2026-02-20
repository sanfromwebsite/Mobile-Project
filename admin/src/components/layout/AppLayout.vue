<script setup>
import AppSidebar from "./AppSidebar.vue";
import AppHeader from "./AppHeader.vue";
</script>

<template>
    <div class="flex h-screen bg-gray-50 overflow-hidden">
        <AppSidebar />
        <div class="flex-1 flex flex-col overflow-hidden">
            <AppHeader />
            <main class="flex-1 overflow-auto p-6">
                <RouterView />
            </main>
        </div>
    </div>
</template>

<!-- component is imported via <script setup> above -->
