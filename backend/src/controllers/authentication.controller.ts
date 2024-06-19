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
        return res.status(200).json({
          data: null,
          error: "Username/Password null",
          status: 200,
        });
      }

      const user = await db.user.findFirst({
        where: {
          username,
        },
      });

      if (!user) {
        return res.status(200).json({
          data: null,
          error: "User doesnt exist!",
          status: 200,
        });
      }

      const passwordMatch = await bcrypt.compare(password, user.password);

      if (!passwordMatch) {
        return res.status(200).json({
          data: null,
          error: "Password doesnt match",
          status: 200,
        });
      }

      const data = {
        id: user.id,
        username: user.username,
        image: user.image,
      };

      return res.status(201).json({ data: data, error: null, status: 201 });
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
      const { username, password, image }: User = await req.body;

      const user = await db.user.findFirst({
        where: {
          username,
        },
      });

      if (user) {
        if (image) {
          unlinkSync(`./public/uploads/${image}`);
        }
        return res
          .status(200)
          .json({ data: null, error: "User already exist!!", status: 200 });
      }

      const passwordHash = await bcrypt.hash(password, 10);

      const response = await db.user.create({
        data: {
          username: username,
          password: passwordHash,
          image: image,
        },
      });

      return res.status(201).json({ data: response, error: null, status: 201 });
    } catch (error) {
      return res
        .status(500)
        .json({ data: null, error: "Something went wrong", status: 500 });
    }
  }
}

export default new AuthenticationController();
