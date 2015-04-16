package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.RelativeLayout;

/**
 * Created by anthonylipscomb on 3/29/15.
 */
public class NotificationsView extends RelativeLayout {
    public NotificationsView(Context context) {
        super(context);
        init(context);
    }

    public NotificationsView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public NotificationsView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
    }

    private void init(Context context) {
        if(isInEditMode()) return;
    }
}
