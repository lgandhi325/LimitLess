package com.limitless.app.utils;

import java.util.Date;

/**
 * Created by anthonylipscomb on 4/8/15.
 */
public class ViewUtil {
    public static String getTimeElapsed(Date dateCreated) {
        Date now = new Date();
        long elapsed = (now.getTime() - dateCreated.getTime())/1000;
        StringBuilder builder = new StringBuilder();

        int days = 3600 * 24;
        int hours = 3600;
        int minutes = 60;

        if(elapsed > days) {
            builder.append((int) elapsed / days);
            builder.append("d");
        } else if(elapsed > hours) {
            builder.append((int) elapsed / hours);
            builder.append("h");
        } else if(elapsed > minutes) {
            builder.append((int) elapsed / minutes);
            builder.append("m");
        } else {
            builder.append((int) elapsed);
            builder.append("s");
        }

        return builder.toString();
    }
}
