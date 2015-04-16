package com.limitless.app.activities;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Typeface;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.InputEvent;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.limitless.app.R;
import com.limitless.app.data.LimitlessDataSource;
import com.limitless.app.interfaces.LimitLessGenericCallback;
import com.limitless.app.utils.KeyboardUtil;
import com.parse.LogInCallback;
import com.parse.ParseAnonymousUtils;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class MainActivity extends ActionBarActivity implements View.OnClickListener, LimitLessGenericCallback<Void> {
    public static final String TAG = MainActivity.class.getName();
    private LimitlessDataSource dataSource;
    private View rootView;

    private View buttonLayout;
    private Button logInButton;
    private Button signUpButton;

    // Sign up Views
    private View signUpLayout;
    private TextView signUpBackButton;
    private EditText emailAddress;
    private EditText firstNameField;
    private EditText lastNameField;
    private EditText usernameField;
    private EditText passwordField;
    private Button signUpSubmitButton;

    // Log in views
    private View logInLayout;
    private TextView logInBackButton;
    private EditText logInUsernameField;
    private EditText logInPasswordField;
    private Button logInSubmitButton;

    // Loading Layout
    private View loadingLayout;

    private enum SplashActionLayout {
        BUTTON, LOGIN, SIGNUP, LOADING;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        super.onCreate(savedInstanceState);
        dataSource = LimitlessDataSource.get();

        setupActionBar();
        initializeViews();
        checkIfLoggedIn();

        switchToView(SplashActionLayout.BUTTON, rootView);
    }

    private void checkIfLoggedIn() {
        // Determine whether the current user is an anonymous user
        if (ParseAnonymousUtils.isLinked(ParseUser.getCurrentUser())) {
            // If user is anonymous, send the user to LoginSignupActivity.class
            switchToView(SplashActionLayout.SIGNUP, rootView);
        } else {
            // If current user is NOT anonymous user
            // Get current user data from Parse.com
            ParseUser currentUser = ParseUser.getCurrentUser();
            if (currentUser != null) {
                switchToView(SplashActionLayout.LOADING, rootView);
                initData();
            } else {
                switchToView(SplashActionLayout.SIGNUP, rootView);
            }
        }
    }

    private void setupActionBar() {
        ActionBar actionBar = getSupportActionBar();
        actionBar.hide();
    }

    private void initializeViews() {
        setContentView(R.layout.activity_main);
        rootView = findViewById(R.id.main_activity_root_view);

        buttonLayout = findViewById(R.id.splash_button_layout);
        logInButton = (Button) findViewById(R.id.log_in_button);
        signUpButton = (Button) findViewById(R.id.sign_up_button);

        signUpLayout = findViewById(R.id.splash_sign_up_layout);
        signUpBackButton = (TextView) findViewById(R.id.sign_up_back_button);
        emailAddress = (EditText) findViewById(R.id.sign_up_email_field);
        firstNameField = (EditText) findViewById(R.id.sign_up_first_name_field);
        lastNameField = (EditText) findViewById(R.id.sign_up_last_name_field);
        usernameField = (EditText) findViewById(R.id.sign_up_username_field);
        passwordField = (EditText) findViewById(R.id.sign_up_password_field);
        signUpSubmitButton = (Button) findViewById(R.id.sign_up_submit_button);

        signUpSubmitButton.setImeActionLabel("Sign Up!", EditorInfo.IME_ACTION_DONE);
        signUpSubmitButton.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    signUp();
                    return true;
                }
                return false;
            }
        });

        logInLayout = findViewById(R.id.splash_log_in_layout);
        logInBackButton = (TextView) findViewById(R.id.log_in_back_button);
        logInUsernameField = (EditText) findViewById(R.id.log_in_username_field);
        logInPasswordField = (EditText) findViewById(R.id.log_in_password_field);
        logInSubmitButton = (Button) findViewById(R.id.log_in_submit_button);

        loadingLayout = findViewById(R.id.splash_loading_layout);

        signUpBackButton.setOnClickListener(this);
        signUpSubmitButton.setOnClickListener(this);

        logInSubmitButton.setOnClickListener(this);
        logInBackButton.setOnClickListener(this);

        logInButton.setOnClickListener(this);
        signUpButton.setOnClickListener(this);

        Typeface myTypeface = Typeface.createFromAsset(getAssets(), "fonts/zapfino.ttf");
        TextView myTextView = (TextView)findViewById(R.id.myTextView);
        myTextView.setTypeface(myTypeface);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onClick(View v) {
        if (v == logInButton) {
            switchToView(SplashActionLayout.LOGIN, v);
        }

        if (v == logInSubmitButton) {
            logIn();
        }

        if (v == signUpButton) {
            switchToView(SplashActionLayout.SIGNUP, v);
        }

        if (v == signUpSubmitButton) {
            signUp();
        }

        if (v == signUpBackButton || v == logInBackButton) {
            switchToView(SplashActionLayout.BUTTON, v);
            KeyboardUtil.hideKeyboard(v);
        }
    }

    private void switchToView(SplashActionLayout layout, View v) {
        //KeyboardUtil.hideKeyboard(v);

        switch (layout) {
            case BUTTON:
                buttonLayout.setVisibility(View.VISIBLE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.GONE);
                loadingLayout.setVisibility(View.GONE);
                break;
            case LOGIN:
                buttonLayout.setVisibility(View.GONE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.VISIBLE);
                loadingLayout.setVisibility(View.GONE);
                logInUsernameField.requestFocus();
                break;
            case SIGNUP:
                buttonLayout.setVisibility(View.GONE);
                signUpLayout.setVisibility(View.VISIBLE);
                logInLayout.setVisibility(View.GONE);
                loadingLayout.setVisibility(View.GONE);
                break;
            case LOADING:
                buttonLayout.setVisibility(View.GONE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.GONE);
                loadingLayout.setVisibility(View.VISIBLE);
                break;
            default:
                buttonLayout.setVisibility(View.VISIBLE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.GONE);
                loadingLayout.setVisibility(View.GONE);
        }
    }

    private void logIn() {
        String usernametxt = logInUsernameField.getText().toString();
        String passwordtxt = logInPasswordField.getText().toString();

        // Send data to Parse.com for verification
        ParseUser.logInInBackground(usernametxt, passwordtxt,
                new LogInCallback() {
                    public void done(ParseUser user, ParseException e) {
                        if (user != null) {
                            initData();
                        } else {
                            Toast.makeText(
                                    getApplicationContext(),
                                    "No such user exist, please signup",
                                    Toast.LENGTH_LONG).show();
                        }
                    }
                });

    }

    private void signUp() {
        String emailtxt = emailAddress.getText().toString();
        String usernametxt = usernameField.getText().toString();
        String passwordtxt = passwordField.getText().toString();

        // Force user to fill up the form
        if (usernametxt.equals("") && passwordtxt.equals("")) {
            Toast.makeText(getApplicationContext(),
                    "Please complete the sign up form",
                    Toast.LENGTH_LONG).show();
        } else {
            ParseUser user = new ParseUser();
            user.setEmail(emailtxt);
            user.setUsername(usernametxt);
            user.setPassword(passwordtxt);
            user.put("firstname", firstNameField.getText().toString());
            user.put("lastname", lastNameField.getText().toString());
            user.signUpInBackground(new SignUpCallback() {
                public void done(ParseException e) {
                    if (e == null) {
                        initData();
                    } else {
                        Log.e(TAG, "Sign Up", e);
                        Toast.makeText(getApplicationContext(),
                                "Sign up Error", Toast.LENGTH_LONG)
                                .show();
                    }
                }
            });
        }
    }

    private void goToHomeActivity() {
        new AlertDialog.Builder(this)
                .setMessage("Stop! This app is meant to build up, not tear down, so please, leave your ego at the splash screen.")
                .setPositiveButton("You got it!", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Intent homeActivityIntent = new Intent(MainActivity.this, LandingActivity.class);
                        homeActivityIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        homeActivityIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
                        startActivity(homeActivityIntent);
                    }
                }).show();


    }

    private void initData() {
        dataSource.refresh(this);
    }

    @Override
    public void done(Void v) {
        goToHomeActivity();
    }
}
