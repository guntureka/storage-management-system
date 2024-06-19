import { Request, Response } from "express";
import { readFile } from "fs";
import path from "path";

/**
 * Controller class for handling file uploads and retrieval.
 */
class UploadController {
  /**
   * Creates a new upload.
   * 
   * @param {Request} req - The request object.
   * @param {Response} res - The response object.
   * @returns {Response} The response containing the created upload data or an error message.
   */
  async create(req: Request, res: Response) {
    try {
      const base_url = process.env.BASE_URL;
      const file = req.file;

      if (file) {
        const filename = file.filename;

        const response = {
          filename: filename,
          url: `${base_url}/api/uploads/${filename}`,
        };

        return res
          .status(200)
          .json({ data: response, error: null, status: 200 });
      }
    } catch (error) {
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }

  /**
   * Retrieves an image file from the server and sends it as a response.
   * @param req - The request object.
   * @param res - The response object.
   */
  async get(req: Request, res: Response) {
    try {
      const { filename } = req.params;

      const imagePath = path.join("public", "uploads", filename);

      readFile(imagePath, (err, data) => {
        if (err) {
          return res.status(404).send("Image not found");
        }

        res.setHeader("Content-Type", "image/*");

        res.send(data);
      });
    } catch (error) {
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }
}

export default new UploadController();
