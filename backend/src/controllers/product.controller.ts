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
      const response = await db.product.findMany();

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res.status(500).json(error);
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
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      const response = await db.product.findUnique({
        where: {
          id,
        },
      });

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res.status(500).json(error);
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
      const { name, quantity, categoryId, createdBy, updatedBy }: Product =
        await req.body;
      const file = req.file;

      let filename = file ? file.filename : null;

      const response = await db.product.create({
        data: {
          name: name,
          quantity: quantity,
          image: filename,
          categoryId,
          createdBy,
          updatedBy,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
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
      const { name, quantity, categoryId, createdBy, updatedBy }: Product =
        await req.body;
      const file = req.file;

      if (!id) {
        return res
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      let filename = file ? file.filename : null;

      const product = await db.product.findUnique({
        where: {
          id,
        },
      });

      if (!product) {
        if (file) {
          unlinkSync(`./public/uploads/${filename}`);
        }
        return res
          .status(400)
          .json({ data: null, error: "Product doesnt exist!!", status: 400 });
      }

      if (file) {
        if (product.image) {
          unlinkSync(`./public/uploads/${product.image}`);
        }
      } else {
        if (product.image) {
          filename = product.image;
        }
      }

      const response = await db.product.create({
        data: {
          name: name,
          quantity: quantity,
          image: filename,
          categoryId,
          createdBy,
          updatedBy,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
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
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      const product = await db.product.findUnique({
        where: {
          id,
        },
      });

      if (!product) {
        return res
          .status(400)
          .json({ data: null, error: "Product doesnt exist!!", status: 400 });
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
      return res.status(500).json({ data: null, error: error, status: 200 });
    }
  }
}

export default new ProductController();
