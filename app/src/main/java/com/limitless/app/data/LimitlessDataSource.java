package com.limitless.app.data;

import android.util.Log;

import com.limitless.app.domainObjects.Post;
import com.limitless.app.domainObjects.UserFollows;
import com.limitless.app.interfaces.LimitLessGenericCallback;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by anthonylipscomb on 3/29/15.
 */
public class LimitlessDataSource {
    public static final String TAG = LimitlessDataSource.class.getName();

    private static LimitlessDataSource ds;
    private HashMap<String, UserFollows> followMap;
    private List<Post> feedItems;

    private LimitlessDataSource() {
        followMap = new HashMap<>();
    }

    public static LimitlessDataSource get() {
        if(ds == null) {
            ds = new LimitlessDataSource();
        }
        return ds;
    }

    public UserFollows getFollowRelationship(ParseUser user) {
        return followMap.get(user.getObjectId());
    }

    public void setUserFollows(List<UserFollows> uf) {
        followMap.clear();
        for(UserFollows userFollows : uf) {
            Log.d(TAG, userFollows.getFollowing().getObjectId() + " added to user follows cache");
            followMap.put(userFollows.getFollowing().getObjectId(), userFollows);
        }
    }

    public void setFeedItems(List<Post> feedItems) {
        this.feedItems = feedItems;

        Log.d(TAG, "Set " + feedItems.size() + " feed items");
    }

    public List<Post> getFeedItems() {
        return this.feedItems;
    }

    public void refresh(final LimitLessGenericCallback<Void> callback) {
        ParseQuery<UserFollows> followsQuery = ParseQuery.getQuery(UserFollows.class);
        followsQuery.whereEqualTo("followedBy", ParseUser.getCurrentUser());
        followsQuery.include("following");
        followsQuery.findInBackground(new FindCallback<UserFollows>() {
            @Override
            public void done(List<UserFollows> userFollows, ParseException e) {
                if(e != null) {
                    Log.e(TAG, "user follows", e);
                    callback.done(null);
                    return;
                }

                ds.setUserFollows(userFollows);
                final List<ParseUser> userList = new ArrayList<ParseUser>(userFollows.size());
                for(UserFollows follow : userFollows) {
                    userList.add(follow.getFollowing());
                }

                userList.add(ParseUser.getCurrentUser());

                ParseQuery<Post> query = ParseQuery.getQuery(Post.class);
                query.whereContainedIn("user", userList);
                query.include("user");
                query.orderByDescending("createdAt").findInBackground(new FindCallback<Post>() {
                    @Override
                    public void done(List<Post> posts, ParseException e) {
                        if (e == null) {
                            ds.setFeedItems(posts);
                        } else {
                            Log.e(TAG, "Query", e);
                        }
                        callback.done(null);
                    }
                });
            }
        });
    }

    public static void clear() {
        ds = new LimitlessDataSource();
    }
}
