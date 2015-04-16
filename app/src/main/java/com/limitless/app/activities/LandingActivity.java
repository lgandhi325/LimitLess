package com.limitless.app.activities;

import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.support.v7.app.ActionBarActivity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.data.LimitlessDataSource;
import com.parse.ParseUser;

/**
 * Created by anthonylipscomb on 4/15/15.
 */
public class LandingActivity extends ActionBarActivity implements View.OnClickListener {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_landing);
        getSupportActionBar().hide();

        Typeface myTypeface = Typeface.createFromAsset(getAssets(), "fonts/zapfino.ttf");
        TextView myTextView = (TextView)findViewById(R.id.myTextView);
        myTextView.setTypeface(myTypeface);
    }

    @Override
    public void onClick(View v) {
        if(v.getId() == R.id.icon1) {
            startActivity(new Intent(this, PostHorizontalListActivity.class));
        }
    }

    public void social(View v) {
        ParseUser.logOut();
        LimitlessDataSource.clear();
        Intent splashIntent = new Intent(this, MainActivity.class);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(splashIntent);
    }
}
