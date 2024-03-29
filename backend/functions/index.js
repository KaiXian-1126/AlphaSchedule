const functions = require('firebase-functions')
const express = require("express")
const app = express();
const calendarRouter = require('./api/controllers/calendar_controller')
const userRouter = require("./api/controllers/user_controller")
const eventRouter = require("./api/controllers/event_controller")

app.use(express.json());
app.use('/user', userRouter);
app.use('/calendar', calendarRouter);
app.use('/event', eventRouter);

exports.api = functions.https.onRequest(app)

// To handle "Function Timeout" exception
exports.functionsTimeOut = functions.runWith({
    timeoutSeconds: 300
})
