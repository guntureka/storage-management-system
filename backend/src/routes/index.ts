import express from "express";
import { categoryRoute } from "@/routes/category";
import { userRoute } from "@/routes/user";
import { productRoute } from "@/routes/product";
import authRoute from "@/routes/auth";
import uploadRoute from "./upload";

/**
 * Express router for handling routes.
 */
export const route = express.Router();

/**
 * Mounts the user routes on the "/users" path.
 */
route.use("/users", userRoute);

/**
 * Mounts the category routes on the "/categories" path.
 */
route.use("/categories", categoryRoute);

/**
 * Mounts the product routes on the "/products" path.
 */
route.use("/products", productRoute);

/**
 * Mounts the authentication routes on the "/auth" path.
 */
route.use("/auth", authRoute);

route.use("/uploads", uploadRoute);
