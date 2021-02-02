const calendarModel = require("../models/calendar_model")
const express = require("express");
const userModel = require("../models/user_model");
const { database } = require("firebase-admin");
const router = express.Router();

//For add new calendar
router.post("/:userid", createCalendar);
//For get specific calendar
router.get("/:calendarid", getCalendar);
//For get the calender list of user
router.get("/getCalendarList/:userid", getCalendarList);
// For get the collaborator calendar list of user
router.get("/getCollaboratorCalendarList/:userid", getCollaboratorCalendarList);
//For delete the calendar
router.delete("/:calendarid", deleteCalendar);
// For get the calendar members
router.get("/getCalendarMembers/:calendarid", getCalendarMembers);

router.patch("/update/:calendarid", updateCalendar);

router.patch("/add/:calendarid/:memberid", addColaborator);

router.patch("/delete/:calendarid/:memberid", deleteColaborator);

router

async function createCalendar(req, res, next) {
    const userid = req.params.userid;
    const data = req.body;

    try {
        //Get user information
        const user = await userModel.get(userid);
        if (!user) return res.sendStatus(404);
        //If get user, create calender
        const result = await calendarModel.create(data);
        if (!result) return res.sendStatus(409);
        //Successfully create calender, add the id to user
        user.calendarList.push(result.id);
        const updatedUser = await userModel.update(userid, user);
        if (!updatedUser) return res.sendStatus(404);
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
async function getCollaboratorCalendarList(req, res, next) {
    const userid = req.params.userid;
    try {
        const user = await userModel.get(userid);
        if (!user) return res.sendStatus(404);
        const collaboratorCalendarListId = user.collaboratorCalendarList;
        var collaboratorCalendarList = [];
        for (i = 0; i < collaboratorCalendarListId.length; i++) {
            const calendar = await calendarModel.get(collaboratorCalendarListId[i]);
            if (!calendar) return res.sendStatus(404);
            collaboratorCalendarList.push(calendar);
        }
        return res.json(collaboratorCalendarList);
    } catch (e) {
        return next(e);
    }
}
async function deleteCalendar(req, res, next) {
    const calendarid = req.params.calendarid;

    try {
        const calendar = await calendarModel.get(calendarid);
        if (!calendar) return res.sendStatus(404);
        const calendarOwnerId = calendar.ownerId;
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
        const calendarCollaboratorsId = calendar.membersId;

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
async function getCalendarMembers(req, res, next) {
    const calendarid = req.params.calendarid;
    try {
        const calendar = await calendarModel.get(calendarid);
        if (!calendar) return res.sendStatus(404);
        const membersId = calendar.membersId;
        var memberList = [];
        for (i = 0; i < membersId.length; i++) {
            var user = await userModel.get(membersId[i]);
            if (!user) return res.sendStatus(404);
            memberList.push(user);
        }
        return res.json(memberList);
    } catch (e) {
        return next(e);
    }
}
async function updateCalendar(req, res, next) {
    const calendarid = req.params.calendarid;
    const data = req.body;
    try {
        const result = await calendarModel.get(calendarid);
        if (!result) return res.sendStatus(404);
        Object.keys(data).forEach((key) => (result[key] = data[key]));
        const updateResult = await calendarModel.update(calendarid, result);
        if (!updateResult) return res.sendStatus(404)
        return res.json(result);
    } catch (e) {
        return next(e);
    }

}

async function addColaborator(req, res, next) {
    const calendarid = req.params.calendarid;
    const memberid = req.params.memberid;

    try {
        const result = await calendarModel.get(calendarid);
        if (!result) return res.sendStatus(404);
        result.membersId.push(memberid);
        const updateCalendar = await calendarModel.update(calendarid, result);
        if (!updateCalendar) return res.sendStatus(404)

        const member = await userModel.get(memberid);
        if (!member) return res.sendStatus(404);
        member.collaboratorCalendarList.push(calendarid);
        const updatedUser = await userModel.update(memberid, member);
        if (!updatedUser) return res.sendStatus(404)
        return res.sendStatus(200);
    }
    catch (e) {
        return next(e);
    }
}

async function deleteColaborator(req, res, next) {
    const calendarid = req.params.calendarid;
    const memberid = req.params.memberid;

    try {
        const result = await calendarModel.get(calendarid);
        if (!result) return res.sendStatus(404);
        for (j = 0; j < result.membersId.length; j++) {
            if (result.membersId[j] === memberid) {
                result.membersId.splice(j, 1);
            }
        }
        const updateCalendar = await calendarModel.update(calendarid, result);
        if (!updateCalendar) return res.sendStatus(404)

        const member = await userModel.get(memberid);
        if (!member) return res.sendStatus(404);
        for (j = 0; j < member.collaboratorCalendarList.length; j++) {
            if (member.collaboratorCalendarList[j] === calendarid) {
                member.collaboratorCalendarList.splice(j, 1);
            }
        }
        const updatedUser = await userModel.update(memberid, member);
        if (!updatedUser) return res.sendStatus(404)
        return res.sendStatus(200);
    }
    catch (e) {
        return next(e);
    }
}




module.exports = router;