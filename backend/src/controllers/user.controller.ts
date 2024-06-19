import { db } from "@/utils/db";
import { Request, Response } from "express";
import bcrypt from "bcryptjs";
import { unlinkSync } from "fs";
import { User } from "@prisma/client";

/**
 * Controller class for managing user-related operations.
 */
class userController {
  /**
   * Retrieves all user from the database.
   *
   * @param req - The request object.
   * @param res - The response object.
   */
  async getAll(req: Request, res: Response) {
    try {
      const response = await db.user.findMany();

      res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      res.status(500).json(error);
    }
  }

  /**
   * Retrieves a user by their ID.
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

      const response = await db.user.findUnique({
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
   * Creates a new user.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns The response object with the created user data or an error message.
   */
  async create(req: Request, res: Response) {
    try {
      const { username, password } = await req.body;
      const file = req.file;

      let filename = file ? file.filename : null;

      const user = await db.user.findUnique({
        where: {
          username,
        },
      });

      if (user) {
        if (file) {
          unlinkSync(`./public/uploads/${filename}`);
        }

        return res
          .status(400)
          .json({ data: null, error: "User already exist!!", status: 400 });
      }

      const passwordHash = await bcrypt.hash(password, 10);

      const response = await db.user.create({
        data: {
          username: username,
          password: passwordHash,
          image: filename,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  /**
   * Updates a user's information.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns The updated user data or an error response.
   */
  async update(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const { username, password }: User = await req.body;
      const file = req.file;

      if (!id) {
        return res
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      let filename = file ? file.filename : null;

      const user = await db.user.findUnique({
        where: {
          id,
        },
      });

      if (!user) {
        if (file) {
          unlinkSync(`./public/uploads/${filename}`);
        }
        return res
          .status(415)
          .json({ data: null, error: "User doesnt exist!!", status: 415 });
      }

      if (file) {
        if (user.image) {
          unlinkSync(`./public/uploads/${user.image}`);
        }
      } else {
        if (user.image) {
          filename = user.image;
        }
      }

      let passwordHash = "";

      const passwordMatch = await bcrypt.compare(password, user.password);

      if (password) {
        if (passwordMatch) {
          passwordHash = user.password;
        } else {
          passwordHash = await bcrypt.hash(password, 10);
        }
      } else {
        passwordHash = user.password;
      }

      const response = await db.user.update({
        where: {
          id,
        },
        data: {
          username: username,
          password: passwordHash,
          image: filename,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  /**
   * Deletes a user from the database.
   * If the user has an associated image, it will also be deleted from the file system.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns A JSON response indicating the success of the operation.
   */
  async delete(req: Request, res: Response) {
    try {
      const { id } = req.params;

      if (!id) {
        return res
          .status(400)
          .json({ data: null, error: "ID doesnt exist", status: 400 });
      }

      const user = await db.user.findUnique({
        where: {
          id,
        },
      });

      if (!user)
        return res
          .status(415)
          .json({ data: null, error: "User doesnt exist!", status: 415 });

      if (user.image) {
        unlinkSync(`./public/uploads/${user.image}`);
      }

      const response = await db.user.delete({
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

export default new userController();
