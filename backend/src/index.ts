import express from "express";
import dotenv from "dotenv";
import path from "path";
import { route } from "@/routes";
import "module-alias/register";
import bodyParser from "body-parser";

dotenv.config();

const app = express();
const port = process.env.port || 3000;

app.use(express.json());
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

app.use(express.static(path.join(__dirname, "public")));
app.use("/public", express.static(path.join(__dirname, "public")));

app.use("/api", route);

app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});
