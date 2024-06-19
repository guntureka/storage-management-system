import AuthenticationController from "@/controllers/authentication.controller";
import { upload } from "@/utils/file-uploader";
import express from "express";

export const authRoute = express.Router();

authRoute.post("/login", AuthenticationController.login);
authRoute.post("/register", AuthenticationController.register);

export default authRoute;
