const calendarModel = require("../models/calendar_model")
const express = require("express");
const userModel = require("../models/user_model");
const router = express.Router();

//For add new calendar
router.post("/create", createCalendar);
//For get specific calendar
router.get("/get/:calendarid", getCalendar);

router.get("/getList/:userid", getCalendarList);
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
async function getCalendarList(req, res, next) {
    const userid = req.params.userid;
    try {
        const user = await userModel.get(userid);
        if (!user) return res.sendStatus(404);
        const calendarListId = user.calendarList;
        var calendarList = [];
        for (i = 0; i < calendarListId.length; i++) {
            const calendar = await calendarModel.get(calendarListId[i]);
            if (!calendar) return res.sendStatus(404);
            calendarList.push(calendar);
        }
        return res.json(calendarList);
    } catch (e) {
        return next(e);
    }
}
module.exports = router;