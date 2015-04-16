package com.limitless.app.views;

import android.content.Context;
import android.content.Intent;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.activities.MainActivity;
import com.limitless.app.data.LimitlessDataSource;
import com.limitless.app.interfaces.LimitLessGenericCallback;
import com.parse.ParseUser;
import com.squareup.picasso.Picasso;

/**
 * Created by anthonylipscomb on 3/29/15.
 */
public class ProfileView extends RelativeLayout implements View.OnClickListener{
    private ImageView profileImage;
    private TextView username;
    private Button signOutButton;
    private LimitLessGenericCallback<Void> onImageCaptureClicked;

    public ProfileView(Context context) {
        super(context);
        init(context);
    }

    public ProfileView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public ProfileView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
    }

    private void init(Context c) {
        if(isInEditMode()) return;

        LayoutInflater.from(c).inflate(R.layout.view_profile, this);

        profileImage = (ImageView) findViewById(R.id.profile_picture);
        updateUserImage();
        profileImage.setOnClickListener(this);

        username = (TextView) findViewById(R.id.profile_username);
        username.setText(ParseUser.getCurrentUser().getUsername());

        signOutButton = (Button) findViewById(R.id.sign_out_button);
        signOutButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.sign_out_button:
                signOut();
                break;
            case R.id.profile_picture:
                updateProfilePicture();
                break;
        }
    }

    private void signOut() {
        ParseUser.logOut();
        LimitlessDataSource.clear();
        Intent splashIntent = new Intent(getContext(), MainActivity.class);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        getContext().startActivity(splashIntent);
    }

    private void updateProfilePicture() {
        if(onImageCaptureClicked != null) onImageCaptureClicked.done(null);
    }

    public void setOnImageCaptureClicked(LimitLessGenericCallback<Void> onImageCaptureClicked) {
        this.onImageCaptureClicked = onImageCaptureClicked;
    }

    public void updateUserImage() {
        if(ParseUser.getCurrentUser().getParseFile("profileImage") != null) {
            Picasso.with(getContext()).load(ParseUser.getCurrentUser().getParseFile("profileImage").getUrl()).into(profileImage);
        }
    }
}
