package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.RelativeLayout;

import com.limitless.app.R;

/**
 * Created by anthonylipscomb on 3/24/15.
 */
public class CaptureImageView extends RelativeLayout {
    public CaptureImageView(Context context) {
        super(context);
        initialize(context);
    }

    public CaptureImageView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialize(context);
    }

    public CaptureImageView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initialize(context);
    }

    private void initialize(Context context) {
        if(isInEditMode()) return;

        LayoutInflater.from(context).inflate(R.layout.view_capture_image, this);
    }
}
