package com.limitless.app.dialogs;

import android.app.Dialog;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;

import com.limitless.app.views.DailyTickerView;

/**
 * Created by anthonylipscomb on 4/27/15.
 */
public class DailyTickerDialog extends DialogFragment {

    public static DailyTickerDialog newInstance() {
        DailyTickerDialog dialog = new DailyTickerDialog();
        return dialog;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        Dialog dialog = super.onCreateDialog(savedInstanceState);

        // request a window without the title
        dialog.getWindow().requestFeature(Window.FEATURE_NO_TITLE);
        return dialog;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        DailyTickerView view = new DailyTickerView(getActivity());
        return view;
    }
}
