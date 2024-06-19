import { Request } from "express";
import multer from "multer";
import path from "path";

const FILE_SIZE = 1024 * 1024 * 5;
const FILES = 1;

/**
 * Multer disk storage configuration.
 */
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join("public", "uploads"));
  },
  filename: (req, file, cb) => {
    const suffix = Date.now() + "_" + file.originalname;
    cb(null, suffix.replaceAll(" ", "_"));
  },
});

/**
 * Middleware function for uploading files using multer.
 * @param {object} options - Options for file upload.
 * @param {object} options.storage - Storage engine for file upload.
 * @param {function} options.fileFilter - File filter function.
 * @param {object} options.limits - Limits for file upload.
 * @param {number} options.limits.fileSize - Maximum file size allowed.
 * @param {number} options.limits.files - Maximum number of files allowed.
 */
export const upload = multer({
  storage: storage,
  limits: {
    fileSize: FILE_SIZE,
    files: FILES,
  },
});

// export const upload = (options?: multer.Options) =>
//   multer({
//     storage: options?.storage || storage,
//     fileFilter: options?.fileFilter || multerFilter,
//     limits: {
//       fileSize: options?.limits?.fileSize || FILE_SIZE,
//       files: options?.limits?.files || FILES,
//     },
//   });
