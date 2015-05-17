package com.limitless.app.activities;

import android.app.Dialog;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.res.Configuration;
import android.graphics.Point;
import android.net.Uri;
import android.os.Bundle;
import android.os.Parcelable;
import android.provider.MediaStore;
import android.support.v4.view.MenuItemCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.widget.SearchView;
import android.text.TextUtils;
import android.util.Log;
import android.view.Display;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.TranslateAnimation;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import com.limitless.app.R;
import com.limitless.app.adapters.DrawerItemAdapter;
import com.limitless.app.data.DrawerItem;
import com.limitless.app.data.HomeActivityState;
import com.limitless.app.data.drawer.DrawerDataSource;
import com.limitless.app.dialogs.PostTextDialog;
import com.limitless.app.dialogs.SelectPostTypeDialog;
import com.limitless.app.domainObjects.Post;
import com.limitless.app.enums.PostType;
import com.limitless.app.interfaces.BottomActionBarListener;
import com.limitless.app.interfaces.LimitLessGenericCallback;
import com.limitless.app.interfaces.PostTextCallback;
import com.limitless.app.interfaces.PostTypeSelectionCallback;
import com.limitless.app.utils.IOUtil;
import com.limitless.app.utils.ImageUtil;
import com.limitless.app.views.CaptureImageView;
import com.limitless.app.views.NotificationsView;
import com.limitless.app.views.PostListView;
import com.limitless.app.views.ProfileView;
import com.limitless.app.views.UserSearchResultsView;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParsePush;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.parse.SaveCallback;
import com.soundcloud.android.crop.Crop;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import bolts.Capture;

/**
 * Created by anthonylipscomb on 3/14/15.
 */
public class HomeActivity extends LimitlessActivity implements PostTypeSelectionCallback,
        PostTextCallback, AdapterView.OnItemClickListener, View.OnClickListener, View.OnFocusChangeListener {
    private static final String TAG = HomeActivity.class.getName();
    private static final String TITLE = "LIMITless";
    private static final int REQUEST_IMAGE_CAPTURE = 1001;
    private static final int IMAGE_SIDE_LENGTH = 1024;

    private String mCurrentPhotoPath;
    private DrawerLayout mDrawerLayout;
    private ActionBarDrawerToggle mDrawerToggle;
    private CharSequence mDrawerTitle;
    private CharSequence mTitle;

    private DrawerDataSource drawerDataSource;
    private MenuItem actionBarMenuItem;
    private SearchView actionBarSearchView;
    private PostListView postListView;
    private NotificationsView notificationsView;
    private ProfileView profileView;
    private CaptureImageView captureImageView;
    private UserSearchResultsView searchResultsListView;
    private ListView leftDrawer;
    private HomeActivityState state;

    private Uri outputFileUri;
    private boolean profilePictureImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        checkIfSubscribedToPushNotifications();
        setupActionBar();

        state = HomeActivityState.Feed;

        drawerDataSource = new DrawerDataSource();

        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        leftDrawer = (ListView) findViewById(R.id.left_drawer);
        searchResultsListView = (UserSearchResultsView) findViewById(R.id.search_results_list_view);
        postListView = (PostListView) findViewById(R.id.post_list_view);
        notificationsView = (NotificationsView) findViewById(R.id.notifications_view);
        profileView = (ProfileView) findViewById(R.id.profile_view);
        captureImageView = (CaptureImageView) findViewById(R.id.capture_image_view);

        postListView.setFabButtonListener(this);

        profileView.setOnImageCaptureClicked(new LimitLessGenericCallback<Void>() {
            @Override
            public void done(Void data) {
                profilePictureImage = true;
                startImageIntent();
            }
        });

        mDrawerToggle = new ActionBarDrawerToggle(
                this,                  /* host Activity */
                mDrawerLayout,         /* DrawerLayout object */
                R.string.drawer_open,  /* "open drawer" description */
                R.string.drawer_close  /* "close drawer" description */
        ) {

            /** Called when a drawer has settled in a completely closed state. */
            public void onDrawerClosed(View view) {
                super.onDrawerClosed(view);
                getSupportActionBar().setTitle(mDrawerTitle);
            }

            /** Called when a drawer has settled in a completely open state. */
            public void onDrawerOpened(View drawerView) {
                super.onDrawerOpened(drawerView);
            }
        };

        // Set the drawer toggle as the DrawerListener
        mDrawerLayout.setDrawerListener(mDrawerToggle);

        DrawerItemAdapter drawerItemAdapter = new DrawerItemAdapter(this);
        leftDrawer.setAdapter(drawerItemAdapter);
        leftDrawer.setOnItemClickListener(this);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu items for use in the action bar
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.home_activity_actions, menu);

        actionBarMenuItem = menu.findItem(R.id.action_search);
        actionBarMenuItem.setVisible(false);

        actionBarSearchView = (SearchView) MenuItemCompat.getActionView(actionBarMenuItem);
        actionBarSearchView.setOnSearchClickListener(this);
        actionBarSearchView.setOnQueryTextFocusChangeListener(this);

        return super.onCreateOptionsMenu(menu);
    }

    private void setupActionBar() {
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setHomeButtonEnabled(true);
    }

    private void checkIfSubscribedToPushNotifications() {
        if (ParseUser.getCurrentUser().getList("channels") == null) {
            ParsePush.subscribeInBackground("", new SaveCallback() {
                @Override
                public void done(ParseException e) {
                    if (e == null) {
                        Log.d("com.parse.push", "successfully subscribed to the broadcast channel.");
                    } else {
                        Log.e("com.parse.push", "failed to subscribe for push", e);
                    }
                }
            });
        }
    }

    @Override
    protected String getActionBarTitle() {
        return TITLE;
    }

    @Override
    protected boolean isTopLevelActivity() {
        return super.isTopLevelActivity();
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        mDrawerToggle.syncState();
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        mDrawerToggle.onConfigurationChanged(newConfig);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (mDrawerToggle.onOptionsItemSelected(item)) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void logout() {
        ParseUser.logOut();
        Intent logoutIntent = new Intent(this, MainActivity.class);
        logoutIntent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
        logoutIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        logoutIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(logoutIntent);
        finish();
    }

    private void showPostDialog() {
        SelectPostTypeDialog dialog = new SelectPostTypeDialog();
        dialog.setCallback(this);
        dialog.show(getSupportFragmentManager(), SelectPostTypeDialog.class.getName());
    }

    @Override
    public void submitPost(Dialog dialog, String text) {
        dialog.dismiss();

        Post newPost = new Post();
        newPost.setUser(ParseUser.getCurrentUser());
        newPost.setMessage(text);
        newPost.saveInBackground(new SaveCallback() {
            @Override
            public void done(ParseException e) {
                if (e == null) {
                    postListView.refresh();
                } else {
                    Log.e(TAG, "Post", e);
                }
            }
        });
    }

    @Override
    public void cancelPost(Dialog dialog) {
        dialog.dismiss();
    }

    @Override
    public void imageItemSelected(Dialog dialog) {
        dialog.dismiss();
        startImageIntent();
    }

    @Override
    public void textItemSelected(Dialog dialog) {
        dialog.dismiss();
        PostTextDialog ptd = new PostTextDialog();
        ptd.setCallback(this);
        ptd.show(getSupportFragmentManager(), PostTextDialog.class.getName());
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        DrawerItem drawerItem = drawerDataSource.getDrawerItem(position);

        switch (drawerItem.type) {
            case Feed:
                changeState(HomeActivityState.Feed);
                break;
            case Search:
                changeState(HomeActivityState.Search);
                break;
            case Notifications:
                changeState(HomeActivityState.Notifications);
                break;
            case Profile:
                changeState(HomeActivityState.Profile);
                break;
            default:
                switchToFeed();
        }
        mDrawerLayout.closeDrawers();
    }

    @Override
    public void onClick(View v) {
        /*if (v == findViewById(R.id.fab)) {
            if (state == HomeActivityState.Feed) {
                showPostDialog();
            }
        } else {
            search();
        }*/
    }

    private void search() {
        String userQuery = actionBarSearchView.getQuery().toString();


        Log.d(TAG, "searching: " + userQuery);
        //if(TextUtils.isEmpty(userQuery)) return;

        ParseQuery<ParseUser> parseQuery = ParseQuery.getQuery(ParseUser.class);
        parseQuery.whereContains("username", userQuery);
        parseQuery.findInBackground(new FindCallback<ParseUser>() {
            @Override
            public void done(List<ParseUser> parseUsers, ParseException e) {
                searchResultsListView.setData(parseUsers);
            }
        });
    }

    private void changeState(HomeActivityState state) {
        this.state = state;

        switch (state) {
            case Feed:
                switchToFeed();
                break;
            case Search:
                switchToSearch();
                break;
            case Notifications:
                switchToNotifications();
                break;
            case Profile:
                switchToProfile();
                break;
            default:
                switchToFeed();
                break;
        }
    }

    private void switchToFeed() {
        mDrawerTitle = "LimitLess";

        postListView.setVisibility(View.VISIBLE);
        searchResultsListView.setVisibility(View.GONE);
        notificationsView.setVisibility(View.GONE);
        profileView.setVisibility(View.GONE);

        actionBarMenuItem.setVisible(false);
        actionBarMenuItem.collapseActionView();
    }

    private void switchToSearch() {
        mDrawerTitle = "Search";

        postListView.setVisibility(View.GONE);
        searchResultsListView.setVisibility(View.VISIBLE);
        notificationsView.setVisibility(View.GONE);
        profileView.setVisibility(View.GONE);

        actionBarMenuItem.setVisible(true);
        actionBarMenuItem.expandActionView();
    }

    private void switchToNotifications() {
        mDrawerTitle = "Notifications";

        postListView.setVisibility(View.GONE);
        searchResultsListView.setVisibility(View.GONE);
        notificationsView.setVisibility(View.VISIBLE);
        profileView.setVisibility(View.GONE);

        actionBarMenuItem.setVisible(false);
        actionBarMenuItem.collapseActionView();
    }

    private void switchToProfile()  {
        mDrawerTitle = "My Profile (" + ParseUser.getCurrentUser().getUsername() + ")";

        postListView.setVisibility(View.GONE);
        searchResultsListView.setVisibility(View.GONE);
        notificationsView.setVisibility(View.GONE);
        profileView.setVisibility(View.VISIBLE);

        actionBarMenuItem.setVisible(false);
        actionBarMenuItem.collapseActionView();
    }

    @Override
    public void onFocusChange(View v, boolean hasFocus) {
        if (v == actionBarSearchView && !hasFocus) {
            search();
        }
    }

    private void startImageIntent() {
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
        if(!profilePictureImage) {
            Post newPost = new Post();
            newPost.setUser(ParseUser.getCurrentUser());
            newPost.setImage(new File(mCurrentPhotoPath));
            newPost.setType(PostType.Image);
            newPost.saveInBackground(new SaveCallback() {
                @Override
                public void done(ParseException e) {
                    if (e == null) {
                        postListView.refresh();
                    } else {
                        Log.e(TAG, "Upload Image", e);
                        Toast.makeText(HomeActivity.this, "Could not upload image", Toast.LENGTH_SHORT).show();
                    }
                }
            });
        } else {
            profilePictureImage = false;
            try {
                ParseFile userImage = new ParseFile(IOUtil.readFile(new File(mCurrentPhotoPath)));
                ParseUser.getCurrentUser().put("profileImage", userImage);
                ParseUser.getCurrentUser().saveInBackground(new SaveCallback() {
                    @Override
                    public void done(ParseException e) {
                        ParseUser.getCurrentUser().fetchIfNeededInBackground(new GetCallback<ParseObject>() {
                            @Override
                            public void done(ParseObject parseObject, ParseException e) {
                                profileView.updateUserImage();
                            }
                        });
                    }
                });
            } catch (IOException ioe) {
                Log.e(TAG, "upload User Image", ioe);
            }
        }
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
