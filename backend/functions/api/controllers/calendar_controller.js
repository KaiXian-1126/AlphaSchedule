const calendarModel = require("../models/calendar_model")
const express = require("express");
const userModel = require("../models/user_model");
const router = express.Router();

//For add new calendar
router.post("/create", createCalendar);
//For get specific calendar
router.get("/get/:calendarid", getCalendar);
//For get the calender list of user
router.get("/getList/:userid", getCalendarList);
//For delete the calendar
router.delete("/delete/:calendarid", deleteCalendar);

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
async function deleteCalendar(req, res, next) {
    const calendarid = req.params.calendarid;

    try {
        const calendar = await calendarModel.get(calendarid);
        if (!calendar) return res.sendStatus(404);
        const calendarOwnerId = calendar.owner;
        // To get the owner user information
        const calendarOwner = await userModel.get(calendarOwnerId);
        if (!calendarOwner) return res.sendStatus(404);
        //Remove the calendar id from calendarList
        for (i = 0; i < calendarOwner.calendarList.length; i++) {
            if (calendarOwner.calendarList[i] === calendarid) {
                calendarOwner.calendarList.splice(i, 1);
            }
        }
        var result = userModel.update(calendarOwnerId, calendarOwner);
        if (!result) return res.sendStatus(404);
        // To get the collaborator user information
        const calendarCollaboratorsId = calendar.members;

        for (i = 0; i < calendarCollaboratorsId.length; i++) {
            const calendarCollaborator = await userModel.get(calendarCollaboratorsId[i]);
            if (!calendarCollaborator) return res.sendStatus(404);
            for (j = 0; j < calendarCollaborator.collaboratorCalendarList.length; j++) {
                if (calendarCollaborator.collaboratorCalendarList[j] === calendarid) {
                    calendarCollaborator.collaboratorCalendarList.splice(j, 1);
                }
            }
            result = userModel.update(calendarCollaboratorsId[i], calendarCollaborator);
            if (!result) return res.sendStatus(404);
        }
        // Delete the calendar in calendar collection
        result = await calendarModel.delete(calendarid);
        if (!result) return res.sendStatus(404);
        return res.sendStatus(200);
    } catch (e) {
        return next(e);
    }
}
module.exports = router;