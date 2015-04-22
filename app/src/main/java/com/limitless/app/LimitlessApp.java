package com.limitless.app;

import android.app.Application;

import com.limitless.app.domainObjects.Post;
import com.limitless.app.domainObjects.UserFollows;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseObject;
import com.parse.ParseUser;

/**
 * Created by anthonylipscomb on 3/14/15.
 */
public class LimitlessApp extends Application {
    private static Application lla;

    private static final String APPLICATION_ID = "3pGycgMOZVb4S4QXaOxbE5SCT2jGrcqUDcmj3IrK";
    private static final String CLIENT_ID = "7BINGAYUVWEeDp21RMysBJ1qSn4C6izd47W39IR6";

    @Override
    public void onCreate() {
        super.onCreate();
        lla = this;

        ParseObject.registerSubclass(Post.class);
        ParseObject.registerSubclass(UserFollows.class);

        Parse.initialize(this, APPLICATION_ID, CLIENT_ID);

        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();

        // If you would like all objects to be private by default, remove this
        // line.
        defaultACL.setPublicReadAccess(true);

        ParseACL.setDefaultACL(defaultACL, true);

        ImageLoaderConfiguration configuration =
                ImageLoaderConfiguration.createDefault(this);

        ImageLoader.getInstance().init(configuration);
    }

    public static Application getApp() {
        return lla;
    }
}
