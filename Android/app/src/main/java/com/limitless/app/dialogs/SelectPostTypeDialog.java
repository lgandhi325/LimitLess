package com.limitless.app.dialogs;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.limitless.app.R;
import com.limitless.app.interfaces.PostTypeSelectionCallback;

/**
 * Created by anthonylipscomb on 3/17/15.
 */
public class SelectPostTypeDialog extends DialogFragment {
    private PostTypeSelectionCallback callback;

    private View cameraItem;
    private View textItem;

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        View v = LayoutInflater.from(getActivity()).inflate(R.layout.dialog_select_post_type, null);

        cameraItem = v.findViewById(R.id.camera_selection);
        cameraItem.setOnClickListener(cameraClickWrapper);

        textItem = v.findViewById(R.id.text_selection);
        textItem.setOnClickListener(textClickWrapper);

        return new AlertDialog.Builder(getActivity()).setView(v).create();
    }

    public void setCallback(PostTypeSelectionCallback callback) {
        this.callback = callback;
    }

    private View.OnClickListener cameraClickWrapper = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(callback != null) {
                callback.imageItemSelected(getDialog());
            }
        }
    };

    private View.OnClickListener textClickWrapper = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(callback != null) {
                callback.textItemSelected(getDialog());
            }
        }
    };
}
