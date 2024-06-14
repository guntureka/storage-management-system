import { Prisma, PrismaClient } from "@prisma/client";

/**
 * Global variable to hold the Prisma client instance.
 * @global
 * @var prisma - The Prisma client instance.
 * @type {PrismaClient | undefined}
 */
declare global {
  var prisma: PrismaClient | undefined;
}

/**
 * The database instance used for interacting with the database.
 * If `globalThis.prisma` is defined, it will be used as the database instance.
 * Otherwise, a new instance of `PrismaClient` will be created and used.
 */
export const db = globalThis.prisma || new PrismaClient();

if (process.env.NODE_ENV !== "production") globalThis.prisma = db;
