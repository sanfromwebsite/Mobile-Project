import { createRouter, createWebHistory } from "vue-router";
import AppLayout from "../components/layout/AppLayout.vue";

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: "/",
            redirect: "/dashboard",
        },
        {
            path: "/login",
            name: "login",
            component: () => import("../view/login.vue"),
        },
        {
            path: "/signup",
            name: "signup",
            component: () => import("../view/signup.vue"),
        },
        {
            path: "/",
            component: AppLayout,
            children: [
                {
                    path: "dashboard",
                    name: "dashboard",
                    component: () => import("../view/index.vue"),
                },
                {
                    path: "roles",
                    name: "roles",
                    component: () => import("../view/Role/index.vue"),
                },
                {
                    path: "roles/create",
                    name: "roles-create",
                    component: () => import("../view/Role/create.vue"),
                },
                {
                    path: "roles/view/:id",
                    name: "roles-view",
                    component: () => import("../view/Role/view/[id].vue"),
                },
                {
                    path: "roles/edit/:id",
                    name: "roles-edit",
                    component: () => import("../view/Role/edit/[id].vue"),
                },
            ],
        },
    ],
});

export default router;
