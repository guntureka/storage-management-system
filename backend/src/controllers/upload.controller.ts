import { Request, Response } from "express";

class UploadController {
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

  async get(req: Request, res: Response) {
    try {
    } catch (error) {
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }
}

export default new UploadController();
