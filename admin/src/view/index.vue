<script setup>
import { ref, onMounted, computed } from 'vue'
import { ShoppingCart, DollarSign, BookOpen, PackageX } from 'lucide-vue-next'

// Stats
const stats = [
  { label: "Today's Orders", value: '26', prefix: '', color: '#2A9D8F', icon: ShoppingCart },
  { label: "Today's Revenue", value: '320.34', prefix: '$', color: '#E9C46A', icon: DollarSign },
  { label: 'Total Books', value: '540', prefix: '', color: '#E76F51', icon: BookOpen },
  { label: 'Out-of-stock Items', value: '30', prefix: '', color: '#9B59B6', icon: PackageX },
]

// Line chart data - Sale by Day
const lineData = [2, 8, 6, 5, 4.5, 3, 1, 6, 5, 2, 8, 4, 4, 7, 2]
const dates = Array.from({ length: 15 }, (_, i) => `10/${6 + i}/2025`)

const lineMin = 0
const lineMax = 9
const chartW = 760
const chartH = 200
const padL = 30
const padR = 20
const padT = 10
const padB = 10

function xPos(i) {
  return padL + (i / (lineData.length - 1)) * (chartW - padL - padR)
}
function yPos(v) {
  return padT + chartH - ((v - lineMin) / (lineMax - lineMin)) * chartH
}

const linePath = computed(() => {
  return lineData.map((v, i) => `${i === 0 ? 'M' : 'L'} ${xPos(i)} ${yPos(v)}`).join(' ')
})

const yGridLines = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

// Bar chart data
const barData = [
  { label: 'Lovely Day', value: 12.54, color: '#E76F51' },
  { label: 'Mind Set of Life', value: 23.44, color: '#2D6A4F' },
  { label: 'King Of Jungle', value: 13.5, color: '#2A9D8F' },
  { label: 'Husband Date', value: 11.34, color: '#E9C46A' },
  { label: 'Night Thinker', value: 4, color: '#9B59B6' },
]
const barMax = 34.56
const barChartH = 150
const barChartW = 320
const barPadB = 20
const barPadL = 50

function barHeight(v) {
  return (v / barMax) * barChartH
}
function barY(v) {
  return barChartH - barHeight(v) + barPadB
}

const barYLines = [0, 9.23, 11.34, 12.54, 23.44, 34.56]

// Pie chart data
const pieData = [
  { label: 'Pending', value: 23, color: '#2A9D8F' },
  { label: 'Shipping', value: 12, color: '#E9C46A' },
  { label: 'Completed', value: 33, color: '#9B59B6' },
  { label: 'Cancelled', value: 20, color: '#2D6A4F' },  // teal/dark green
]

function polarToCartesian(cx, cy, r, deg) {
  const rad = (deg - 90) * Math.PI / 180
  return { x: cx + r * Math.cos(rad), y: cy + r * Math.sin(rad) }
}

function pieSlice(cx, cy, r, startDeg, endDeg) {
  const s = polarToCartesian(cx, cy, r, startDeg)
  const e = polarToCartesian(cx, cy, r, endDeg)
  const large = endDeg - startDeg > 180 ? 1 : 0
  return `M ${cx} ${cy} L ${s.x} ${s.y} A ${r} ${r} 0 ${large} 1 ${e.x} ${e.y} Z`
}

function labelPos(cx, cy, r, startDeg, endDeg) {
  const mid = (startDeg + endDeg) / 2
  return polarToCartesian(cx, cy, r * 0.65, mid)
}

const total = pieData.reduce((s, d) => s + d.value, 0)
const pieSlices = computed(() => {
  let cursor = 0
  return pieData.map(d => {
    const start = cursor
    const end = cursor + (d.value / total) * 360
    cursor = end
    return { ...d, start, end }
  })
})
</script>

<template>
  <div class="min-h-screen bg-gray-50 p-6 font-sans">

    <!-- Stat Cards -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 pb-6">
      <div
        v-for="stat in stats"
        :key="stat.label"
        class="flex items-center gap-4 bg-white rounded-2xl px-5 py-4 shadow-sm"
      >
        <div
          class="w-12 h-12 rounded-2xl flex items-center justify-center shrink-0"
          :style="{ backgroundColor: stat.color }"
        >
          <component :is="stat.icon" class="w-6 h-6 text-white" />
        </div>
        <div>
          <p class="text-xs text-gray-400 font-medium">{{ stat.label }}</p>
          <p class="text-2xl font-bold text-gray-800">{{ stat.prefix }}{{ stat.value }}</p>
        </div>
      </div>
    </div>

    <!-- Line Chart: Sale by Day -->
    <div class="bg-white rounded-2xl p-6 shadow-sm pb-6">
      <h2 class="text-xl font-bold text-gray-800">Sale by Day</h2>
      <p class="text-xs text-gray-400 pb-4">Last 15 days</p>

      <div class="overflow-x-auto">
        <svg :width="chartW + padL + padR" :height="chartH + padT + padB + 60" class="min-w-full">
          <!-- Y grid lines & labels -->
          <g v-for="val in yGridLines" :key="val">
            <line
              :x1="padL" :y1="yPos(val)"
              :x2="chartW - padR" :y2="yPos(val)"
              stroke="#E5E7EB" stroke-width="1"
            />
            <text :x="padL - 5" :y="yPos(val) + 4" text-anchor="end" font-size="10" fill="#9CA3AF">{{ val }}</text>
          </g>

          <!-- Line -->
          <path :d="linePath" fill="none" stroke="#2D6A4F" stroke-width="2" stroke-linejoin="round" />

          <!-- Dots -->
          <circle
            v-for="(v, i) in lineData"
            :key="i"
            :cx="xPos(i)" :cy="yPos(v)"
            r="4" fill="white" stroke="#2D6A4F" stroke-width="2"
          />

          <!-- X labels -->
          <text
            v-for="(d, i) in dates"
            :key="i"
            :x="xPos(i)"
            :y="chartH + padT + padB + 50"
            text-anchor="end"
            font-size="9"
            fill="#9CA3AF"
            :transform="`rotate(-45, ${xPos(i)}, ${chartH + padT + padB + 50})`"
          >{{ d }}</text>
        </svg>
      </div>
    </div>

    <!-- Bottom Row -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 pt-4">

      <!-- Bar Chart -->
      <div class="bg-white rounded-2xl p-6 shadow-sm">
        <div class="flex gap-6">
          <!-- SVG bar chart -->
          <div class="flex-1 overflow-x-auto">
            <svg :width="barChartW" :height="barChartH + barPadB + 40">
              <!-- Y grid lines -->
              <g v-for="val in [0, 9.23, 11.34, 12.54, 23.44, 34.56]" :key="val">
                <line
                  :x1="barPadL" :y1="barY(val) - barPadB"
                  :x2="barChartW" :y2="barY(val) - barPadB"
                  stroke="#E5E7EB" stroke-width="1"
                />
                <text :x="barPadL - 4" :y="barY(val) - barPadB + 4" text-anchor="end" font-size="9" fill="#9CA3AF">
                  ${{ val }}
                </text>
              </g>

              <!-- Bars -->
              <g v-for="(bar, i) in barData" :key="bar.label">
                <rect
                  :x="barPadL + i * 52 + 10"
                  :y="barY(bar.value) - barPadB"
                  width="32"
                  :height="barHeight(bar.value)"
                  :fill="bar.color"
                  rx="4"
                />
                <text
                  :x="barPadL + i * 52 + 26"
                  :y="barChartH + barPadB + 10"
                  text-anchor="middle"
                  font-size="9"
                  fill="#6B7280"
                >{{ bar.label.split(' ')[0] }}</text>
                <text
                  v-if="bar.label.split(' ').length > 1"
                  :x="barPadL + i * 52 + 26"
                  :y="barChartH + barPadB + 21"
                  text-anchor="middle"
                  font-size="9"
                  fill="#6B7280"
                >{{ bar.label.split(' ').slice(1).join(' ') }}</text>
              </g>
            </svg>
          </div>

          <!-- Legend -->
          <div class="flex flex-col gap-2 justify-center shrink-0">
            <div v-for="bar in barData" :key="bar.label" class="flex items-center gap-2">
              <div class="w-3 h-3 rounded-sm shrink-0" :style="{ backgroundColor: bar.color }" />
              <span class="text-xs text-gray-600">{{ bar.label }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Pie Chart -->
      <div class="bg-white rounded-2xl p-6 shadow-sm flex flex-col items-center justify-center">
        <svg width="220" height="220" viewBox="0 0 220 220">
          <g v-for="slice in pieSlices" :key="slice.label">
            <path
              :d="pieSlice(110, 110, 90, slice.start, slice.end)"
              :fill="slice.color"
              stroke="white"
              stroke-width="2"
            />
            <text
              :x="labelPos(110, 110, 90, slice.start, slice.end).x"
              :y="labelPos(110, 110, 90, slice.start, slice.end).y"
              text-anchor="middle"
              dominant-baseline="middle"
              font-size="12"
              font-weight="bold"
              fill="white"
            >{{ slice.value }}%</text>
          </g>
        </svg>

        <!-- Legend -->
        <div class="flex flex-wrap justify-center gap-x-4 gap-y-1 pt-2">
          <div v-for="d in pieData" :key="d.label" class="flex items-center gap-1.5">
            <div class="w-3 h-3 rounded-sm" :style="{ backgroundColor: d.color }" />
            <span class="text-xs text-gray-600">{{ d.label }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>