package com.limitless.app.domainObjects;

import android.util.Log;

import com.limitless.app.enums.PostType;
import com.limitless.app.utils.IOUtil;
import com.parse.ParseClassName;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseRelation;
import com.parse.ParseUser;

import java.io.File;
import java.io.IOException;

/**
 * Created by anthonylipscomb on 3/17/15.
 */

@ParseClassName("Post")
public class Post extends ParseObject {
    private static final String TAG = Post.class.getName();

    public Post() { }

    public ParseUser getUser() {
        return getParseUser("user");
    }

    public void setUser(ParseUser user) {
        put("user", user);
    }

    public String getMessage() {
        return getString("message");
    }

    public void setMessage(String message) {
        put("message", message);
    }

    public ParseFile getImage() {
        return getParseFile("image");
    }

    public void setImage(File image) {
        try {
            ParseFile file = new ParseFile(IOUtil.readFile(image));
            put("image", file);
        } catch (IOException ioe) {
            Log.d(TAG, "read image file", ioe);
        }
    }

    public PostType getType() {
        switch (getInt("type")) {
            case 0:
                return PostType.Message;
            case 1:
                return PostType.Image;
            default:
                return PostType.Message;
        }
    }

    public void setType(PostType type) {
        switch (type) {
            case Message:
                put("type", 0);
                break;
            case Image:
                put("type", 1);
                break;
        }
    }
}
