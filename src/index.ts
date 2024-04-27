import { createApp } from "./server";
import swagger from "swagger-ui-express";
import swaggerJson from "./docs/swagger.json";

const app = createApp();

const PORT = 8080;

app.use("/docs", swagger.serve);
app.use("/docs", swagger.setup(swaggerJson));

app.listen(PORT, () => {
    console.log(`Server ready at: http://localhost:${PORT}`);
})
