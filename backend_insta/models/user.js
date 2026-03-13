const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  fullName: {
    type: String,
    required: true,
    trim: true,
  },

  username: {
    type: String,
    required: true,
    trim: true,
  },

  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const result =
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return result.test(value);
      },
      message: "Please Enter a Valid Email Address",
    },
  },

  password: {
    type: String,
    required: true,
    validate: {
      validator: (value) => {
        //Check length 8 char pass
        return value.length >= 8;
      },
      message: "Password must be at least 8 characters long",
    },
  },

  profilePicture: {
    type: String,
    // It's a good idea to set a default "placeholder" avatar
    default: "",
    trim: true,
  },
  bio: {
    type: String,
    default: "",
    trim: true,
    
    maxLength: [160, "Bio cannot exceed 160 characters"],
  },

  isVerifiedIcon: {
    type: Boolean,
    default: false,
  },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
