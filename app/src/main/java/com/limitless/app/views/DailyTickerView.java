package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.LinearLayout;

import com.limitless.app.R;

/**
 * Created by anthonylipscomb on 4/27/15.
 */
public class DailyTickerView extends LinearLayout {
    public DailyTickerView(Context context) {
        super(context);
        init(context);
    }

    public DailyTickerView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public DailyTickerView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
    }

    private void init(Context context) {
        if(isInEditMode()) return;

        LayoutInflater.from(context).inflate(R.layout.view_daily_ticker, this);
    }
}
