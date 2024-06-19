import { db } from "@/utils/db";
import { Category } from "@prisma/client";
import { Request, Response } from "express";

class CategoryController {
  /**
   * Retrieves all category.
   *
   * @param req - The request object.
   * @param res - The response object.
   */
  async getAll(req: Request, res: Response) {
    try {
      const response = await db.category.findMany();

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  /**
   * Retrieves a category by its ID.
   * @param req - The request object.
   * @param res - The response object.
   */
  async getById(req: Request, res: Response) {
    try {
      const { id } = req.params;

      if (!id) {
        return res
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      const response = await db.category.findUnique({
        where: {
          id,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  /**
   * Creates a new category.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns The created category data.
   */
  async create(req: Request, res: Response) {
    try {
      const { name }  = await req.body;

      if (!name) {
        return res
          .status(400)
          .json({ data: null, error: "Data doesnt exist", status: 400 });
      }

      const response = await db.category.create({
        data: {
          name,
        },
      });

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  async update(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const { name }: Category = await req.body;

      if (!id) {
        return res
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      if (!name) {
        return res
          .status(400)
          .json({ data: null, error: "Data doesnt exist", status: 400 });
      }

      const response = await db.category.update({
        where: {
          id,
        },
        data: {
          name,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  async delete(req: Request, res: Response) {
    try {
      const { id } = req.params;

      if (!id) {
        return res
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      const response = await db.category.delete({
        where: {
          id,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }
}

export default new CategoryController();
