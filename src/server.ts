import cors from "cors";
import express from "express";

export function createApp() {
    const app = express();

    app.use(express.json());
    app.use(cors());

    return app;
}

