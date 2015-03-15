package com.limitless.app.utils;

import android.content.Context;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

import com.limitless.app.LimitlessApp;

/**
 * Created by anthonylipscomb on 3/14/15.
 */
public class KeyboardUtil {
    public static void showKeyboard() {
        InputMethodManager imm = (InputMethodManager) LimitlessApp.getApp().getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,0);
    }

    public static void hideKeyboard(View v) {
        InputMethodManager imm = (InputMethodManager) LimitlessApp.getApp().getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(v.getWindowToken(),0);
    }
}
