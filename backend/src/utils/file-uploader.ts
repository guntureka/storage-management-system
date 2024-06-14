import { Request } from "express";
import multer from "multer";

const FILE_SIZE = 1024 * 1024 * 5;
const FILES = 1;

/**
 * Multer disk storage configuration.
 */
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./public/uploads/");
  },
  filename: (req, file, cb) => {
    const suffix = Date.now() + "_" + file.originalname;
    cb(null, suffix.replaceAll(" ", "_"));
  },
});

/**
 * Multer filter function to validate the file mimetype.
 * @param req - The Express request object.
 * @param file - The file object being uploaded.
 * @param cb - The callback function to be called with the validation result.
 */
const multerFilter = (
  req: Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback
) => {
  const mimetype = ["image/jpeg", "image/jpg", "image/png", "image/*"];

  if (mimetype.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

/**
 * Middleware function for uploading files using multer.
 * @param {object} options - Options for file upload.
 * @param {object} options.storage - Storage engine for file upload.
 * @param {function} options.fileFilter - File filter function.
 * @param {object} options.limits - Limits for file upload.
 * @param {number} options.limits.fileSize - Maximum file size allowed.
 * @param {number} options.limits.files - Maximum number of files allowed.
 * @returns {function} - Middleware function for file upload.
 */
export const upload = multer({
  storage: storage,
  fileFilter: multerFilter,
  limits: {
    fileSize: FILE_SIZE,
    files: FILES,
  },
});
