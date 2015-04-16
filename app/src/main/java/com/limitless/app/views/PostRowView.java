package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.RelativeLayout;

import com.limitless.app.domainObjects.Post;

/**
 * Created by anthonylipscomb on 4/8/15.
 */
public abstract class PostRowView extends RelativeLayout {

    public PostRowView(Context context) {
        super(context);
    }

    public PostRowView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public PostRowView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public abstract void setData(Post data);
}
