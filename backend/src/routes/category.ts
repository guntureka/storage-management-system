import express from "express";
import categoryController from "@/controllers/category.controller";

/**
 * Express router for category routes.
 */
export const categoryRoute = express.Router();

/**
 * GET route to retrieve all categories.
 * @route GET /category
 * @returns {Response} The response object containing the list of categories.
 */
categoryRoute.get("/", categoryController.getAll);

/**
 * GET route to retrieve a category by its ID.
 * @route GET /category/:id
 * @param {string} id - The ID of the category.
 * @returns {Response} The response object containing the category with the specified ID.
 */
categoryRoute.get("/:id", categoryController.getById);

/**
 * POST route to create a new category.
 * @route POST /category/create
 * @returns {Response} The response object containing the newly created category.
 */
categoryRoute.post("/create", categoryController.create);

/**
 * PUT route to update a category by its ID.
 * @route PUT /category/update/:id
 * @param {string} id - The ID of the category to update.
 * @returns {Response} The response object indicating the success of the update operation.
 */
categoryRoute.put("/update/:id", categoryController.update);

/**
 * DELETE route to delete a category by its ID.
 * @route DELETE /category/delete/:id
 * @param {string} id - The ID of the category to delete.
 * @returns {Response} The response object indicating the success of the delete operation.
 */
categoryRoute.delete("/delete/:id", categoryController.delete);

export default categoryRoute;
