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
 * Route to create a new product.
 * @route POST /create
 * @param {File} image - The image file for the product.
 */
productRoute.post("/create", upload.single("image"), ProductController.create);

/**
 * Route to update a product by ID.
 * @route PUT /update/:id
 * @param {string} id - The ID of the product to update.
 * @param {File} image - The updated image file for the product.
 */
productRoute.put(
  "/update/:id",
  upload.single("image"),
  ProductController.update
);

/**
 * Route to delete a product by ID.
 * @route DELETE /delete/:id
 * @param {string} id - The ID of the product to delete.
 */
productRoute.delete("/delete/:id", ProductController.delete);

export default productRoute;
