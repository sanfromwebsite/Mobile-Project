<script setup>
import { ref, computed, watch } from "vue";
import {
    Search,
    SlidersHorizontal,
    ChevronLeft,
    ChevronRight,
} from "lucide-vue-next";

const props = defineProps({
    columns: {
        type: Array,
        required: true,
        // Each column: { key, label, align?: 'left'|'center'|'right', width?: string }
    },
    data: {
        type: Array,
        required: true,
    },
    rowKey: {
        type: String,
        default: "id",
    },
    selectable: {
        type: Boolean,
        default: true,
    },
    searchable: {
        type: Boolean,
        default: true,
    },
    filterable: {
        type: Boolean,
        default: true,
    },
    paginated: {
        type: Boolean,
        default: true,
    },
    totalItems: {
        type: Number,
        default: 0,
    },
    totalPages: {
        type: Number,
        default: 1,
    },
    searchPlaceholder: {
        type: String,
        default: "Search...",
    },
    perPageOptions: {
        type: Array,
        default: () => [10, 20, 50],
    },
    tabs: {
        type: Array,
        default: () => [],
    },
    modelValue: {
        type: Array,
        default: () => [],
    },
});

const emit = defineEmits([
    "update:modelValue",
    "search",
    "filter",
    "page-change",
    "per-page-change",
    "tab-change",
    "edit",
    "delete",
]);

const searchQuery = ref("");
const perPage = ref(props.perPageOptions[0] || 10);
const currentPage = ref(1);
const activeTab = ref(props.tabs.length > 0 ? props.tabs[0] : "");

// Selection
const selectedRows = computed({
    get: () => props.modelValue,
    set: (val) => emit("update:modelValue", val),
});

const allSelected = computed(
    () =>
        props.data.length > 0 &&
        selectedRows.value.length === props.data.length,
);

const toggleAll = (e) => {
    selectedRows.value = e.target.checked
        ? props.data.map((row) => row[props.rowKey])
        : [];
};

const toggleRow = (id) => {
    if (selectedRows.value.includes(id)) {
        selectedRows.value = selectedRows.value.filter((r) => r !== id);
    } else {
        selectedRows.value = [...selectedRows.value, id];
    }
};

// Pagination
const goToPage = (page) => {
    if (page >= 1 && page <= props.totalPages) {
        currentPage.value = page;
        emit("page-change", page);
    }
};

const visiblePages = computed(() => {
    const total = props.totalPages;
    const current = currentPage.value;
    const pages = [];

    if (total <= 5) {
        for (let i = 1; i <= total; i++) pages.push(i);
    } else {
        if (current <= 3) {
            pages.push(1, 2, 3);
        } else if (current >= total - 2) {
            pages.push(total - 2, total - 1, total);
        } else {
            pages.push(current - 1, current, current + 1);
        }
    }

    return pages;
});

const showLastPage = computed(() => {
    const total = props.totalPages;
    return total > 5 && !visiblePages.value.includes(total);
});

const showEllipsis = computed(() => {
    const total = props.totalPages;
    if (total <= 5) return false;
    const lastVisible = visiblePages.value[visiblePages.value.length - 1];
    return lastVisible < total - 1;
});

// Search
const onSearch = () => {
    emit("search", searchQuery.value);
};

// Tab
const switchTab = (tab) => {
    activeTab.value = tab;
    emit("tab-change", tab);
};

// Per page
watch(perPage, (val) => {
    currentPage.value = 1;
    emit("per-page-change", val);
});

// Computed display range
const showingFrom = computed(() => {
    return (currentPage.value - 1) * perPage.value + 1;
});

const showingTo = computed(() => {
    const to = currentPage.value * perPage.value;
    return to > props.totalItems ? props.totalItems : to;
});

// Alignment helper
const alignClass = (align) => {
    if (align === "right") return "text-right";
    if (align === "center") return "text-center";
    return "text-left";
};
</script>

<template>
    <div
        v-if="tabs.length > 0 || searchable || filterable"
        class="flex items-center justify-between border-b border-gray-100"
    >
        <!-- Search + Filter -->
        <div class="flex items-center gap-2 pb-3 pt-4">
            <div
                v-if="searchable"
                class="flex items-center gap-2 border border-gray-200 rounded-lg px-3 py-2 bg-gray-50 transition-all duration-200"
            >
                <Search class="w-4 h-4 text-gray-500 shrink-0" />
                <input
                    v-model="searchQuery"
                    type="text"
                    :placeholder="searchPlaceholder"
                    class="bg-transparent text-sm outline-none text-gray-600 placeholder-gray-300 w-36"
                    @input="onSearch"
                />
            </div>
            <button
                v-if="filterable"
                @click="$emit('filter')"
                class="p-2 border border-gray-200 rounded-lg bg-gray-50 hover:bg-gray-100 hover:border-gray-300 transition-all duration-200"
            >
                <SlidersHorizontal class="w-4 h-4 text-gray-500" />
            </button>
        </div>
    </div>
    <div class="bg-white rounded-lg border border-gray-100 overflow-hidden shadow">
        <!-- Table -->
        <table class="w-full">
            <thead>
                <tr class="border-b border-gray-100">
                    <th v-if="selectable" class="w-10 px-5 py-3.5 bg-gray-50">
                        <input
                            type="checkbox"
                            :checked="allSelected"
                            @change="toggleAll"
                            class="accent-green-600 w-4 h-4 cursor-pointer"
                        />
                    </th>
                    <th
                        v-for="col in columns"
                        :key="col.key"
                        class="text-sm bg-gray-50 text-gray-900 font-bold uppercase tracking-wider px-4 py-3.5"
                        :class="[
                            alignClass(col.align),
                            col.width ? col.width : '',
                        ]"
                        :style="
                            col.align === 'right'
                                ? 'padding-right: 1.25rem'
                                : ''
                        "
                    >
                        {{ col.label }}
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="(row, index) in data"
                    :key="row[rowKey]"
                    class="border-b border-gray-100 hover:bg-green-50/40 transition-colors duration-150 group"
                    :class="
                        selectable && selectedRows.includes(row[rowKey])
                            ? 'bg-green-50/30'
                            : ''
                    "
                >
                    <td v-if="selectable" class="px-5 py-4">
                        <input
                            type="checkbox"
                            :checked="selectedRows.includes(row[rowKey])"
                            @change="toggleRow(row[rowKey])"
                            class="accent-green-600 w-4 h-4 rounded cursor-pointer"
                        />
                    </td>
                    <td
                        v-for="col in columns"
                        :key="col.key"
                        class="px-4 py-4"
                        :class="alignClass(col.align)"
                        :style="
                            col.align === 'right'
                                ? 'padding-right: 1.25rem'
                                : ''
                        "
                    >
                        <!-- Named slot for custom cell rendering -->
                        <slot
                            :name="`cell-${col.key}`"
                            :row="row"
                            :value="row[col.key]"
                            :index="index"
                        >
                            <span class="text-sm text-gray-700">{{
                                row[col.key]
                            }}</span>
                        </slot>
                    </td>
                </tr>

                <!-- Empty State -->
                <tr v-if="data.length === 0">
                    <td
                        :colspan="columns.length + (selectable ? 1 : 0)"
                        class="text-center py-12 text-gray-400 text-sm"
                    >
                        No data available
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
            <!-- Pagination -->
        <div
            v-if="paginated"
            class="flex items-center justify-between px-5 py-4 border-t border-gray-50"
        >
            <!-- Per page -->
            <div class="flex items-center gap-2">
                <span class="text-xs text-gray-400">Per page</span>
                <select
                    v-model="perPage"
                    class="border border-gray-200 rounded-lg px-2 py-1 text-xs text-gray-600 outline-none bg-gray-50 cursor-pointer hover:border-gray-300 transition-colors"
                >
                    <option
                        v-for="opt in perPageOptions"
                        :key="opt"
                        :value="opt"
                    >
                        {{ opt }}
                    </option>
                </select>
            </div>

            <!-- Page buttons -->
            <div class="flex items-center gap-1">
                <button
                    @click="goToPage(currentPage - 1)"
                    :disabled="currentPage === 1"
                    class="w-8 h-8 flex items-center justify-center text-gray-400 hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                >
                    <ChevronLeft class="w-3.5 h-3.5" />
                </button>

                <button
                    v-for="page in visiblePages"
                    :key="page"
                    @click="goToPage(page)"
                    class="w-8 h-8 rounded-lg text-xs font-semibold transition-all duration-150"
                    :class="
                        currentPage === page
                            ? ' text-green-500 border border-green-500'
                            : 'border border-gray-200 text-gray-500 hover:bg-gray-50'
                    "
                >
                    {{ page }}
                </button>

                <span v-if="showEllipsis" class="px-1 text-gray-300 text-sm"
                    >···</span
                >

                <button
                    v-if="showLastPage"
                    @click="goToPage(totalPages)"
                    class="w-8 h-8 rounded-lg text-xs font-semibold transition-colors"
                    :class="
                        currentPage === totalPages
                            ? ' text-white border-green-600 shadow-sm shadow-green-200'
                            : 'border border-gray-200 text-gray-500 hover:bg-gray-50'
                    "
                >
                    {{ totalPages }}
                </button>

                <button
                    @click="goToPage(currentPage + 1)"
                    :disabled="currentPage === totalPages"
                    class="w-8 h-8 rounded-lg border border-gray-200 flex items-center justify-center text-gray-400 hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                >
                    <ChevronRight class="w-3.5 h-3.5" />
                </button>
            </div>
        </div>
</template>
