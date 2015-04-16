package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.domainObjects.Post;
import com.limitless.app.utils.ViewUtil;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.squareup.picasso.Picasso;

/**
 * Created by anthonylipscomb on 3/17/15.
 */
public class TextPostRowView extends PostRowView {
    private static final String TAG = TextPostRowView.class.getName();

    private ImageView opProfileImage;
    private TextView messageTextView;
    private TextView opTextView;
    private TextView timeElapsed;

    public TextPostRowView(Context context) {
        super(context);
        initialize(context);
    }

    public TextPostRowView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialize(context);
    }

    public TextPostRowView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initialize(context);
    }

    private void initialize(Context context) {
        if (isInEditMode()) return;

        LayoutInflater.from(context).inflate(R.layout.view_text_post_list_row, this);
        messageTextView = (TextView) findViewById(R.id.text_post_message);
        opTextView = (TextView) findViewById(R.id.op);
        timeElapsed = (TextView) findViewById(R.id.time_elapsed);
        opProfileImage = (ImageView) findViewById(R.id.op_profile_image);
    }

    public void setData(final Post data) {
        messageTextView.setText(data.getMessage());
        opTextView.setText(data.getUser().getUsername());
        timeElapsed.setText(ViewUtil.getTimeElapsed(data.getCreatedAt()));

        if(data.getUser().getParseFile("profileImage") != null) {
            Picasso.with(getContext()).load(data.getUser().getParseFile("profileImage").getUrl()).into(opProfileImage);
        } else {
            opProfileImage.setVisibility(GONE);
        }
    }
}
