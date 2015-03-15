package com.limitless.app.activities;

import android.os.Bundle;
import android.view.MenuItem;

/**
 * Created by anthonylipscomb on 3/14/15.
 */
public class HomeActivity extends LimitlessActivity {
    private static final String TITLE = "LIMITless";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected String getActionBarTitle() {
        return TITLE;
    }

    @Override
    protected boolean isTopLevelActivity() {
        return super.isTopLevelActivity();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        return super.onOptionsItemSelected(item);
    }
}
