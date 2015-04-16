package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.domainObjects.Post;
import com.limitless.app.utils.ViewUtil;
import com.squareup.picasso.Callback;
import com.squareup.picasso.Picasso;

/**
 * Created by anthonylipscomb on 4/8/15.
 */
public class ImageListRowView extends  PostRowView {
    private ImageView imageView;
    private TextView op;
    private TextView datePosted;
    private ImageView opImageView;

    public ImageListRowView(Context context) {
        super(context);
        if(!isInEditMode()) init(context);
    }

    public ImageListRowView(Context context, AttributeSet attrs) {
        super(context, attrs);
        if(!isInEditMode()) init(context);
    }

    public ImageListRowView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        if(!isInEditMode()) init(context);
    }

    private void init(Context context) {
        LayoutInflater.from(context).inflate(R.layout.view_image_list_row, this);

        imageView = (ImageView) findViewById(R.id.image_post_view);
        op = (TextView) findViewById(R.id.op);
        opImageView = (ImageView) findViewById(R.id.op_profile_image);
        datePosted = (TextView) findViewById(R.id.time_elapsed);
    }

    @Override
    public void setData(Post data) {
        Picasso.with(getContext()).load(data.getImage().getUrl()).into(imageView, new Callback() {
            @Override
            public void onSuccess() {

            }

            @Override
            public void onError() {

            }
        });
        op.setText(data.getUser().getUsername());
        datePosted.setText(ViewUtil.getTimeElapsed(data.getCreatedAt()));

        if(data.getUser().getParseFile("profileImage") != null) {
            Picasso.with(getContext()).load(data.getUser().getParseFile("profileImage").getUrl()).into(opImageView);
        } else {
            opImageView.setVisibility(GONE);
        }
    }
}
