package com.limitless.app;

import android.app.Application;

/**
 * Created by anthonylipscomb on 3/14/15.
 */
public class LimitlessApp extends Application {
    private static Application lla;

    @Override
    public void onCreate() {
        super.onCreate();
        lla = this;
    }

    public static Application getApp() {
        return lla;
    }
}
