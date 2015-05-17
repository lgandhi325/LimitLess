package com.limitless.app.interfaces;

import android.app.Dialog;

/**
 * Created by anthonylipscomb on 3/17/15.
 */
public interface PostTextCallback {
    public void submitPost(Dialog dialog, String text);
    public void cancelPost(Dialog dialog);
}
