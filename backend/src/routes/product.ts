import { upload } from "@/utils/file-uploader";
import express from "express";
import ProductController from "@/controllers/product.controller";

/**
 * Express router for handling product-related routes.
 * @type {express.Router}
 */
export const productRoute = express.Router();

/**
 * Route to get all products.
 * @route GET /
 */
productRoute.get("/", ProductController.getAll);

/**
 * Route to get a product by ID.
 * @route GET /:id
 * @param {string} id - The ID of the product.
 */
productRoute.get("/:id", ProductController.getById);

/**
 * Route to get a product by Product ID.
 * @route GET /:id
 * @param {string} id - The ID of the category.
 */
productRoute.get("/categories/:id", ProductController.getByCategoryId);

/**
 * Route to create a new product.
 * @route POST /create
 */
productRoute.post("/create", ProductController.create);

/**
 * Route to update a product by ID.
 * @route PUT /update/:id
 * @param {string} id - The ID of the product to update.
 */
productRoute.put("/update/:id", ProductController.update);

/**
 * Route to delete a product by ID.
 * @route DELETE /delete/:id
 * @param {string} id - The ID of the product to delete.
 */
productRoute.delete("/delete/:id", ProductController.delete);

export default productRoute;
