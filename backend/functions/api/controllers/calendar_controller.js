const calendarModel = require("../models/calendar_model")
const express = require("express");
const router = express.Router();

//For add new calendar
router.post("/create", createCalendar);
//For get specific calendar
router.get("/get/:calendarid", getCalendar);


async function createCalendar(req, res, next) {
    try {
        const data = req.body;
        const result = await calendarModel.create(data);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);

    } catch (e) {
        return next(e);
    }
}
async function getCalendar(req, res, next) {
    const calendarid = req.params.calendarid;
    try {
        const result = await calendarModel.get(calendarid);
        if (!result) return res.sendStatus(404);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
}

module.exports = router;