package com.limitless.app.dialogs;

import android.app.AlertDialog;
import android.app.Dialog;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;

import com.limitless.app.R;
import com.limitless.app.activities.HomeActivity;
import com.limitless.app.interfaces.PostTextCallback;

/**
 * Created by anthonylipscomb on 3/17/15.
 */
public class PostTextDialog extends DialogFragment {
    private PostTextCallback callback;

    private EditText messageField;
    private View submitButton;
    private View cancelButton;

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        View v = LayoutInflater.from(getActivity()).inflate(R.layout.dialog_post_text, null);

        messageField = (EditText) v.findViewById(R.id.text_post_message_field);

        submitButton = v.findViewById(R.id.text_post_submit_button);
        submitButton.setOnClickListener(submitButtonWrapper);

        cancelButton = v.findViewById(R.id.text_post_cancel_button);
        cancelButton.setOnClickListener(cancelButtonWrapper);

        return new AlertDialog.Builder(getActivity()).setView(v).create();
    }

    public void setCallback(PostTextCallback callback) {
        this.callback = callback;
    }

    private View.OnClickListener submitButtonWrapper = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(callback != null) callback.submitPost(getDialog(), messageField.getText().toString());
        }
    };

    private View.OnClickListener cancelButtonWrapper = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(callback != null) callback.cancelPost(getDialog());
        }
    };
}
