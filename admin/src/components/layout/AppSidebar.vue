<script setup>
import { ref } from "vue";
import { RouterLink, useRoute } from "vue-router";
import { Icon } from "@iconify/vue";
import {
    ChevronLeft,
    LogOut,
} from "lucide-vue-next";
import { useRouter } from "vue-router";

const router = useRouter();
const route = useRoute();
const collapsed = ref(false);
const searchQuery = ref("");
const isActive = (path) => {
    if (!path) return false;
    const current = route.path || "";
    return current === path || current.startsWith(path + "/");
};

const navGroups = [
    {
        items: [
            { label: "Dashboard", path: "/dashboard", icon: "ph:squares-four" },
        ],
    },
    {
        group: "Product Management",
        items: [
            { label: "Books", path: "/books", icon: "ph:book-open" },
            { label: "Categories", path: "/category", icon: "ph:tag" },
            { label: "Promotion / Flash Sale", path: "/promotion", icon: "ph:lightning" },
        ],
    },
    {
        group: "Order Management",
        items: [
            { label: "Orders", path: "/orders", icon: "ph:shopping-bag" },
            { label: "Customers", path: "/customer", icon: "ph:users" },
            { label: "Banners", path: "/banner", icon: "ph:image" },
        ],
    },
    {
        group: "Payment Management",
        items: [
            {
                label: "Delivery & Payment",
                path: "/delivery",
                icon: "ph:credit-card",
            },
            { label: "Invoices", path: "/invoices", icon: "ph:file-text" },
        ],
    },
    {
        items: [{ label: "Roles Management", path: "/roles", icon: "ph:gear" }],
    },
];

const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    router.push("/login");
};
</script>

<template>
    <aside
        class="flex flex-col h-screen bg-white border-r border-gray-100 transition-all duration-300 ease-in-out shadow-sm"
        :class="collapsed ? 'w-16' : 'w-64'"
    >
        <div
            class="flex items-center h-20 border-b border-gray-100 transition-all duration-300"
            :class="collapsed ? 'justify-center px-0' : 'justify-between px-4'"
        >
            <div
                class="flex items-center transition-all duration-300 overflow-hidden"
                :class="collapsed ? 'w-0 opacity-0' : 'w-32 opacity-100'"
            >
                <img
                    src="../../assets/images/logo.svg"
                    alt="logo"
                    class="w-20 h-20 shrink-0 object-contain"
                />
            </div>
            <button
                @click="collapsed = !collapsed"
                class="text-gray-400 hover:text-green-600 transition-colors shrink-0 p-2 rounded-lg hover:bg-gray-50"
            >
                <ChevronLeft
                    class="w-4 h-4 transition-transform duration-300"
                    :class="collapsed ? 'rotate-180' : ''"
                />
            </button>
        </div>

        <!-- Nav -->
        <nav class="flex-1 overflow-y-auto py-0 space-y-1">
            <template v-for="(group, gi) in navGroups" :key="gi">
                <p
                    v-if="group.group && !collapsed"
                    class="px-3 pt-5 pb-1 text-xs text-gray-400 font-medium tracking-wider "
                >
                    {{ group.group }}
                </p>
                <div
                    v-if="group.group && collapsed"
                    class="border-t border-gray-100 my-1"
                />

                <RouterLink
                    v-for="item in group.items"
                    :key="item.path"
                    :to="item.path"
                    class="flex items-center gap-2 mx-2 px-3 py-3 rounded-xl font-medium text-gray-600 hover:bg-green-50 hover:text-green-600 transition-all duration-200 group"
                    :class="
                        isActive(item.path)
                            ? 'bg-green-50 text-green-600 font-semibold'
                            : ''
                    "
                >
                    <Icon
                        v-if="typeof item.icon === 'string'"
                        :icon="item.icon"
                        class="w-5 h-5 text-gray-600"
                        :class="
                            isActive(item.path)
                                ? 'text-green-600'
                                : 'text-gray-400 group-hover:text-green-600'
                        "
                    />
                    <component
                        v-else
                        :is="item.icon"
                        class="w-5 h-5 shrink-0 transition-colors"
                        :class="
                            isActive(item.path)
                                ? 'text-green-600'
                                : 'text-gray-400 group-hover:text-green-600'
                        "
                    />
                    <span
                        class="text-sm whitespace-nowrap transition-all duration-300 overflow-hidden"
                        :class="
                            collapsed ? 'w-0 opacity-0' : 'w-auto opacity-100'
                        "
                    >
                        {{ item.label }}
                    </span>
                </RouterLink>
            </template>
        </nav>

        <div
            class="border-t border-gray-100 transition-all duration-300"
            :class="collapsed ? 'p-2' : 'p-3'"
        >
            <button
                @click="handleLogout"
                class="flex items-center gap-2 w-full rounded-xl text-red-500 hover:bg-red-50 transition-all duration-200 group"
                :class="collapsed ? 'justify-center py-3 px-0' : 'px-3 py-3'"
            >
                <LogOut class="w-5 h-5 shrink-0 transition-colors" />
                <span
                    class="text-sm whitespace-nowrap transition-all duration-300 overflow-hidden font-medium"
                    :class="collapsed ? 'w-0 opacity-0' : 'w-auto opacity-100'"
                >
                    Logout
                </span>
            </button>
        </div>
    </aside>
</template>
