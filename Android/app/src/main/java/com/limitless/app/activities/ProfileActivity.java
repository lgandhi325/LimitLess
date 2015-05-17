package com.limitless.app.activities;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.support.v7.app.ActionBarActivity;
import android.view.LayoutInflater;
import android.view.Window;
import android.view.WindowManager;

import com.limitless.app.views.ProfileView;

/**
 * Created by anthonylipscomb on 5/2/15.
 */
public class ProfileActivity extends ActionBarActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        super.onCreate(savedInstanceState);
        setContentView(new ProfileView(this));

        getSupportActionBar().hide();
    }
}
