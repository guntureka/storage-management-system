import { db } from "@/utils/db";
import { Product } from "@prisma/client";
import { Request, Response } from "express";
import { unlinkSync } from "fs";

class ProductController {
  /**
   * Retrieves all products.
   *
   * @param req - The request object.
   * @param res - The response object.
   */
  async getAll(req: Request, res: Response) {
    try {
      const response = await db.product.findMany({
        orderBy: {
          updatedAt: "asc",
        },
      });

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }

  /**
   * Retrieves a product by its ID.
   * @param req - The request object.
   * @param res - The response object.
   * @returns The product data if found, or an error response if not found.
   */
  async getById(req: Request, res: Response) {
    try {
      const { id } = req.params;

      if (!id) {
        return res
          .status(200)
          .json({ data: null, error: "ID doesnt exist", status: 200 });
      }

      const response = await db.product.findUnique({
        where: {
          id,
        },
      });

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }

  /**
   * Retrieves products by category ID.
   *
   * @param req - The request object.
   * @param res - The response object.
   */
  async getByCategoryId(req: Request, res: Response) {
    try {
      const { id } = req.params;

      if (!id) {
        return res
          .status(200)
          .json({ data: null, error: "ID doesnt exist", status: 200 });
      }

      const response = await db.product.findMany({
        where: {
          categoryId: id,
        },
        orderBy: {
          updatedAt: "asc",
        },
      });

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }

  /**
   * Creates a new product.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns The response containing the created product data or an error.
   */
  async create(req: Request, res: Response) {
    try {
      const {
        name,
        quantity,
        categoryId,
        image,
        createdBy,
        updatedBy,
      }: Product = await req.body;

      const response = await db.product.create({
        data: {
          name: name,
          quantity: quantity,
          image: image,
          categoryId,
          createdBy,
          updatedBy,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }

  /**
   * Updates a product.
   *
   * @param {Request} req - The request object.
   * @param {Response} res - The response object.
   * @returns {Promise<Response>} The updated product response.
   */
  async update(req: Request, res: Response) {
    try {
      const { id } = req.params;
      let { name, quantity, categoryId, image, updatedBy }: Product =
        await req.body;

      if (!id) {
        return res
          .status(200)
          .json({ data: null, error: "ID doesnt exist", status: 200 });
      }

      const product = await db.product.findUnique({
        where: {
          id,
        },
      });

      if (!product) {
        if (image) {
          unlinkSync(`./public/uploads/${image}`);
        }
        return res
          .status(200)
          .json({ data: null, error: "Product doesnt exist!!", status: 200 });
      }

      if (product.image == image) {
        image = product.image;
      } else {
        unlinkSync(`./public/uploads/${product.image}`);
      }

      const response = await db.product.update({
        where: {
          id,
        },
        data: {
          name: name,
          quantity: quantity,
          image: image,
          categoryId,
          updatedBy,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }

  /**
   * Deletes a product by ID.
   * @param req - The request object.
   * @param res - The response object.
   * @returns The deleted product or an error response.
   */
  async delete(req: Request, res: Response) {
    try {
      const { id } = req.params;

      if (!id) {
        return res
          .status(200)
          .json({ data: null, error: "ID doesnt exist", status: 200 });
      }

      const product = await db.product.findUnique({
        where: {
          id,
        },
      });

      if (!product) {
        return res
          .status(200)
          .json({ data: null, error: "Product doesnt exist!!", status: 200 });
      }

      if (product.image) {
        unlinkSync(`./public/uploads/${product.image}`);
      }

      const response = await db.product.delete({
        where: {
          id,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 200 });
    }
  }
}

export default new ProductController();
