import { upload } from "@/utils/file-uploader";
import express from "express";
import { readFile } from "fs";
import path from "path";
import UploadController from '@/controllers/upload.controller'

export const uploadRoute = express.Router();

uploadRoute.get("/:filename", (req, res) => {
  const filename = req.params.filename;
  const imagePath = path.join("public", "uploads", filename);
  console.log(imagePath);

  readFile(imagePath, (err, data) => {
    if (err) {
      return res.status(404).send("Image not found");
    }

    res.setHeader("Content-Type", "image/*");

    res.send(data);
  });
});

uploadRoute.post("/", upload.single("image"), UploadController.create);

export default uploadRoute;
