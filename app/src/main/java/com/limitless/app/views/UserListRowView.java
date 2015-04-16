package com.limitless.app.views;

import android.content.Context;
import android.text.Layout;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.limitless.app.R;
import com.limitless.app.data.LimitlessDataSource;
import com.limitless.app.domainObjects.UserFollows;
import com.parse.ParseException;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.parse.SaveCallback;

/**
 * Created by anthonylipscomb on 3/25/15.
 */
public class UserListRowView extends LinearLayout implements View.OnClickListener, SaveCallback {
    private static final String TAG = UserListRowView.class.getName();
    private LimitlessDataSource dataSource;
    private ParseUser rowUser;
    private TextView usernameTextView;
    private TextView followButton;

    public UserListRowView(Context context) {
        super(context);
        initialize(context);
    }

    public UserListRowView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialize(context);
    }

    public UserListRowView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initialize(context);
    }

    private void initialize(Context context) {
        if(isInEditMode()) return;

        dataSource = LimitlessDataSource.get();

        LayoutInflater.from(context).inflate(R.layout.view_user_list_row, this);
        usernameTextView = (TextView) findViewById(R.id.user_username);
        followButton = (TextView) findViewById(R.id.follow_button);

        followButton.setOnClickListener(this);
    }

    public void setData(ParseUser user) {
        rowUser = user;

        UserFollows relationship = dataSource.getFollowRelationship(user);
        usernameTextView.setText(user.getUsername());

        if(relationship != null) {
            followButton.setText("Following");
            followButton.setEnabled(false);
        }
    }

    @Override
    public void onClick(View v) {
        if(v == followButton) {
            UserFollows newRelationship = new UserFollows();
            newRelationship.setFollowing(rowUser);
            newRelationship.setFollowedBy(ParseUser.getCurrentUser());
            newRelationship.saveInBackground(this);
        }
    }

    @Override
    public void done(ParseException e) {
        if(e == null) {
            followButton.setText("Following");
            followButton.setEnabled(false);
        } else {
            Toast.makeText(getContext(), "Could not follow " + rowUser.getUsername(), Toast.LENGTH_SHORT).show();
        }
    }
}
