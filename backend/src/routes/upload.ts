import { upload } from "@/utils/file-uploader";
import express from "express";
import { readFile } from "fs";
import path from "path";
import UploadController from "@/controllers/upload.controller";

/**
 * Express router for handling file upload routes.
 */
export const uploadRoute = express.Router();

/**
 * GET route for retrieving a file by its filename.
 * @route GET /upload/:filename
 * @param {string} filename - The name of the file to retrieve.
 * @returns {void}
 */
uploadRoute.get("/:filename", UploadController.get);

/**
 * POST route for uploading a file.
 * @route POST /upload
 * @param {FormData} image - The image file to upload.
 * @returns {void}
 */
uploadRoute.post("/", upload.single("image"), UploadController.create);

export default uploadRoute;
