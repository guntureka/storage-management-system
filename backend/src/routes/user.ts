import { upload } from "@/utils/file-uploader";
import express from "express";
import userController from "@/controllers/user.controller";

/**
 * Express router for user-related routes.
 */
export const userRoute = express.Router();

/**
 * Route to get all users.
 * @route GET /
 */
userRoute.get("/", userController.getAll);

/**
 * Route to get a user by ID.
 * @route GET /:id
 * @param {string} id - The ID of the user.
 */
userRoute.get("/:id", userController.getById);

/**
 * Route to create a new user.
 * @route POST /create
 * @param {File} image - The image file for the user.
 */
userRoute.post("/create", upload.single("image"), userController.create);

/**
 * Route to update a user by ID.
 * @route PUT /update/:id
 * @param {string} id - The ID of the user to update.
 * @param {File} image - The updated image file for the user.
 */
userRoute.put("/update/:id", upload.single("image"), userController.update);

/**
 * Route to delete a user by ID.
 * @route DELETE /delete/:id
 * @param {string} id - The ID of the user to delete.
 */
userRoute.delete("/delete/:id", userController.delete);

export default userRoute;
