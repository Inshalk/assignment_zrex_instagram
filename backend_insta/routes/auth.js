const express = require("express");
const User = require("../models/user");

const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { fullName, username, email, password } = req.body;
    const existingEmail = await User.findOne({ email });
    const existingUsername = await User.findOne({ username });
    if (existingEmail && existingUsername) {
      return res
        .status(400)
        .json({
          msg: "User with same email address or username already exist",
        });
    } else {
      //Generate a salt of cost factor 10
      const salt = await bcrypt.genSalt(10);
      //Hash the password using the generated salt
      const hashedPassword = await bcrypt.hash(password, salt);

      let user = new User({
        fullName,
        username,
        email,
        password: hashedPassword,
        isVerified: false,
      });
      user = await user.save();

      res.status(201).json({ msg: "Signup successful Login to continue." });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//signin api endpoint
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const findUser = await User.findOne({ email });
    if (!findUser) {
      return res.status(400).json({ msg: "User not found with this email" });
    } else {
      const isMatch = await bcrypt.compare(password, findUser.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect Password" });
      } else {
        //Remove sensitive information
        const { password, ...userWithoutPassword } = findUser._doc;
        //Sends the Response
        // res.json({ userWithoutPassword });
        // GENERATE THE TOKEN
    const token = jwt.sign({ id: findUser._id }, "passwordKey"); // Use a secure key in production

    // SEND THE TOKEN AND USER DATA
    // We spread user._doc and add the token key explicitly
    res.json({ token, ...findUser._doc })
      }
    }
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});



//Put Route for updating user's details
authRouter.put("/api/users/:id", async (req, res) => {
  try {
    //Request the id from the params and also request name and username
    const { id } = req.params;
    const { fullName, username, bio, profilePicture } = req.body;
    //find the user by id and update
    //The {new:true}option ensures the updated document is returned
    const updatedUser = await User.findByIdAndUpdate(
      id,
      { fullName, username, bio, profilePicture },
      { new: true, runValidators: true },
    );

    if (!updatedUser) {
      return res.status(404).json({ error: "User not found" });
    }
    return res.status(200).json(updatedUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//Fetch all users (exclude password)
authRouter.get("/api/users", async (req, res) => {
  try {
    const users = await User.find().select("-password"); //exclude password
    return res.status(200).json(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//Delete user

authRouter.delete("/api/user/delete-account/:id", async (req, res) => {
  try {
    const { id } = req.params;
    //check available
    const user = await User.findById(id);

    if (!user) {
      return res.status(404).json({ msg: "user  not found" });
    }

    //Delete the user 
    if (user) {
      await User.findByIdAndDelete(id);
    }
    return res.status(200).json({ msg: "User deleted successfully " });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
