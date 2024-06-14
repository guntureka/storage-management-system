import { db } from "@/utils/db";
import { Request, Response } from "express";
import bcrypt from "bcryptjs";
import { User } from "@prisma/client";
import { unlinkSync } from "fs";

/**
 * Controller class for handling authentication-related operations.
 */
class AuthenticationController {
  /**
   * Handles the login functionality.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns A JSON response with the user data if login is successful, or an error message if login fails.
   */
  async login(req: Request, res: Response) {
    try {
      const { username, password }: User = await req.body;

      if (!username || !password) {
        return res.json({
          data: null,
          error: "Username/Password null",
          status: 400,
        });
      }

      const user = await db.user.findUnique({
        where: {
          username,
        },
      });

      if (!user) {
        return res.json({
          data: null,
          error: "User doesnt exist!",
          status: 415,
        });
      }

      const passwordMatch = await bcrypt.compare(password, user.password);

      if (!passwordMatch) {
        return res.json({
          data: null,
          error: "Password doesnt match",
          status: 400,
        });
      }

      return res.status(200).json({ data: user, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }

  /**
   * Registers a new user.
   *
   * @param req - The request object.
   * @param res - The response object.
   * @returns A JSON response with the registered user's data and status code.
   */
  async register(req: Request, res: Response) {
    try {
      const { username, password }: User = await req.body;
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
          .status(415)
          .json({ data: null, error: "User already exist!!", status: 415 });
      }

      const hashedPassword = await bcrypt.hash(password, 10);

      const response = await db.user.create({
        data: {
          username: username,
          password: hashedPassword,
          image: filename,
        },
      });

      return res.status(200).json({ data: response, error: null, status: 200 });
    } catch (error) {
      return res.status(500).json({ data: null, error: error, status: 500 });
    }
  }
}

export default new AuthenticationController();
