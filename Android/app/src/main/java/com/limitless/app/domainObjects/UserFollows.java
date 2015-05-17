package com.limitless.app.domainObjects;

import com.parse.ParseClassName;
import com.parse.ParseObject;
import com.parse.ParseUser;

/**
 * Created by anthonylipscomb on 3/23/15.
 */
@ParseClassName("UserFollows")
public class UserFollows extends ParseObject {
    public UserFollows() {}

    public ParseUser getFollowing() {
        return getParseUser("following");
    }

    public void setFollowing(ParseUser user) {
        put("following", user);
    }

    public ParseUser getFollowedBy() {
        return getParseUser("followedBy");
    }

    public void setFollowedBy(ParseUser user) {
        put("followedBy", user);
    }
}
