package com.limitless.app.views;

import android.content.Context;
import android.graphics.Typeface;
import android.text.Html;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.limitless.app.R;

/**
 * Created by anthonylipscomb on 4/27/15.
 */
public class DailyTickerView extends LinearLayout {
    private TextView tickerMessage;
    private TextView headerTitle;

    private Button postButton;
    private View cancelButton;

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

        tickerMessage = (TextView) findViewById(R.id.ticker_message);
        headerTitle = (TextView) findViewById(R.id.daily_ticker_header_title);
        postButton = (Button) findViewById(R.id.ticker_post_button);
        cancelButton = findViewById(R.id.ticker_cancel_button);

        tickerMessage.setText(Html.fromHtml(context.getString(R.string.daily_ticker_place_holder)));

        //Typeface myTypeface = Typeface.createFromAsset(context.getAssets(), "fonts/zapfino.ttf");
        //headerTitle.setTypeface(myTypeface);
    }

    public void onPostClick(View v) {

    }

    public void onCancelClick(View v) {

    }
}
