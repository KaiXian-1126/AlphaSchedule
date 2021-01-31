const calendarModel = require("../models/calendar_model")
const express = require("express");
const router = express.Router();

//For add new calendar
router.post("/create", createCalendar);

async function createCalendar(req, res, next) {
    try {
        const data = req.body;
        const result = await calendarModel.create(data);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);

    } catch {
        return next(e);
    }
}

module.exports = router;