package com.limitless.app.views;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.Animation;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.domainObjects.Post;
import com.limitless.app.utils.FlipAnimation;
import com.limitless.app.utils.ViewUtil;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.listener.ImageLoadingListener;
import com.nostra13.universalimageloader.core.listener.ImageLoadingProgressListener;
import com.parse.ParseUser;
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

    private View root;
    private View frontView;
    private View backView;

    // Flipped views
    private ImageView flippedThumbnailImage;
    private TextView flippedCaptionTextView;

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

        root = findViewById(R.id.image_list_row_root);
        frontView = findViewById(R.id.row_front);
        backView = findViewById(R.id.row_back);

        flippedThumbnailImage = (ImageView) findViewById(R.id.details_image_view);
        flippedCaptionTextView = (TextView) findViewById(R.id.details_caption_text_view);
    }

    @Override
    public void setData(Post data) {
        Picasso.with(getContext()).load(data.getImage().getUrl()).into(imageView);

        frontView.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                flipCard();
            }
        });

        backView.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                flipCard();
            }
        });

        op.setText(data.getUser().getUsername());
        datePosted.setText(ViewUtil.getTimeElapsed(data.getCreatedAt()));

        flippedCaptionTextView.setText(data.getMessage());
        Picasso.with(getContext())
                .load(data.getImage().getUrl())
                .into(flippedThumbnailImage);

        if(data.getUser().getParseFile("profileImage") != null) {
            Picasso.with(getContext())
                    .load(ParseUser.getCurrentUser().getParseFile("profileImage").getUrl())
                    .fit()
                    .into(opImageView);
        } else {
            opImageView.setVisibility(GONE);
        }
    }

    private void flipCard()
    {
        FlipAnimation flipAnimation = new FlipAnimation(frontView, backView);
        View activeView = frontView;

        if (frontView.getVisibility() == GONE) {
            flipAnimation.reverse();
            activeView = backView;
        } else if(backView.getVisibility() == GONE) {
            flipAnimation.start();
            activeView = frontView;
        }
        activeView.startAnimation(flipAnimation);
    }
}
