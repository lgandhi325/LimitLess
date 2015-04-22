package com.limitless.app.activities;

import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Bundle;
import android.os.Parcelable;
import android.os.PersistableBundle;
import android.provider.MediaStore;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.limitless.app.R;
import com.limitless.app.data.LimitlessDataSource;
import com.limitless.app.domainObjects.Post;
import com.limitless.app.enums.PostType;
import com.limitless.app.utils.ImageUtil;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.listener.ImageLoadingListener;
import com.nostra13.universalimageloader.core.listener.ImageLoadingProgressListener;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SaveCallback;
import com.soundcloud.android.crop.Crop;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by anthonylipscomb on 4/15/15.
 */
public class LandingActivity extends ActionBarActivity implements View.OnClickListener {
    private final String TAG = LandingActivity.class.getName();
    private ImageView profileItemImage;
    private ProgressBar profileProgressBar;

    private static final int REQUEST_IMAGE_CAPTURE = 1001;
    private static final int IMAGE_SIDE_LENGTH = 1024;
    private String mCurrentPhotoPath;
    private Uri outputFileUri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_landing);
        getSupportActionBar().hide();

        profileItemImage = (ImageView) findViewById(R.id.profile_image_view);
        profileProgressBar = (ProgressBar) findViewById(R.id.profile_image_loader);

        ImageLoader.getInstance()
                .displayImage(ParseUser.getCurrentUser().getParseFile("profileImage").getUrl(),
                        profileItemImage, null, new ImageLoadingListener() {
                            @Override
                            public void onLoadingStarted(String imageUri, View view) {

                            }

                            @Override
                            public void onLoadingFailed(String imageUri, View view, FailReason failReason) {

                            }

                            @Override
                            public void onLoadingComplete(String imageUri, View view, Bitmap loadedImage) {
                                profileProgressBar.setVisibility(View.GONE);
                            }

                            @Override
                            public void onLoadingCancelled(String imageUri, View view) {

                            }
                        }, new ImageLoadingProgressListener() {
                            @Override
                            public void onProgressUpdate(String imageUri, View view, int current, int total) {
                                profileProgressBar.setProgress(current);
                            }
                        });

        /*Picasso.with(this)
                .load(ParseUser.getCurrentUser().getParseFile("profileImage").getUrl())
                .into(profileItemImage);*/

        Typeface myTypeface = Typeface.createFromAsset(getAssets(), "fonts/zapfino.ttf");
        TextView myTextView = (TextView)findViewById(R.id.myTextView);
        myTextView.setTypeface(myTypeface);
    }

    @Override
    public void onClick(View v) {
        if(v.getId() == R.id.icon1) {
            startActivity(new Intent(this, PostHorizontalListActivity.class));
        }
    }

    public void social(View v) {
        ParseUser.logOut();
        LimitlessDataSource.clear();
        Intent splashIntent = new Intent(this, MainActivity.class);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        splashIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(splashIntent);
    }

    public void startImageIntent(View v) {
        File sdImageMainDirectory = null;

        try {
            sdImageMainDirectory = ImageUtil.createImageFile();
            mCurrentPhotoPath = sdImageMainDirectory.getAbsolutePath();
            outputFileUri = Uri.fromFile(sdImageMainDirectory);
        } catch (IOException ioe) {
            Log.e(TAG, "createImageFile", ioe);
            return;
        }

        // Camera.
        final List<Intent> cameraIntents = new ArrayList<Intent>();
        final Intent captureIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
        final PackageManager packageManager = getPackageManager();
        final List<ResolveInfo> listCam = packageManager.queryIntentActivities(captureIntent, 0);
        for (ResolveInfo res : listCam) {
            final String packageName = res.activityInfo.packageName;
            final Intent intent = new Intent(captureIntent);
            intent.setComponent(new ComponentName(res.activityInfo.packageName, res.activityInfo.name));
            intent.setPackage(packageName);
            intent.putExtra(MediaStore.EXTRA_OUTPUT, outputFileUri);
            cameraIntents.add(intent);
        }

        // Filesystem.
        final Intent galleryIntent = new Intent();
        galleryIntent.setType("image/*");
        galleryIntent.setAction(Intent.ACTION_GET_CONTENT);

        // Chooser of filesystem options.
        final Intent chooserIntent = Intent.createChooser(galleryIntent, "Select Source");

        // Add the camera options.
        chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, cameraIntents.toArray(new Parcelable[cameraIntents.size()]));

        startActivityForResult(chooserIntent, REQUEST_IMAGE_CAPTURE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                case REQUEST_IMAGE_CAPTURE:
                    captureImage(data);
                    break;
                case Crop.REQUEST_CROP:
                    useImage();
                    break;
            }
        }
    }

    private void useImage() {
        Post newPost = new Post();
        newPost.setUser(ParseUser.getCurrentUser());
        newPost.setImage(new File(mCurrentPhotoPath));
        newPost.setType(PostType.Image);
        newPost.saveInBackground(new SaveCallback() {
            @Override
            public void done(ParseException e) {
                if (e != null) {
                    Log.e(TAG, "Upload Image", e);
                    Toast.makeText(LandingActivity.this, "Could not upload image", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    private void captureImage(Intent data) {
        boolean isCamera;
        if (data == null) {
            isCamera = true;
        } else {
            String action = data.getAction();
            isCamera = action != null && action.equals(MediaStore.ACTION_IMAGE_CAPTURE);
        }

        Uri selectedImageUri;
        if (isCamera) {
            selectedImageUri = outputFileUri;
        } else {
            selectedImageUri = data.getData();
        }

        try {
            ImageUtil.storeImage(ImageUtil.rotateBitmap(ImageUtil.decodeUri(this, selectedImageUri, IMAGE_SIDE_LENGTH), mCurrentPhotoPath), mCurrentPhotoPath);
            Uri fileUri = Uri.fromFile(new File(mCurrentPhotoPath));
            new Crop(fileUri).output(fileUri).start(this);
        } catch (FileNotFoundException e) {
            Log.e(TAG, "could not find image file", e);
        }
    }
}
