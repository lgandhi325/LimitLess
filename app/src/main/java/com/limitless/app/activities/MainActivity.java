package com.limitless.app.activities;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.utils.AnimationUtil;
import com.limitless.app.utils.KeyboardUtil;


public class MainActivity extends ActionBarActivity implements View.OnClickListener {
    public static final String TAG = MainActivity.class.getName();
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

    private enum SplashActionLayout {
        BUTTON, LOGIN, SIGNUP;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setupActionBar();
        initializeViews();
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

        logInLayout = findViewById(R.id.splash_log_in_layout);
        logInBackButton = (TextView) findViewById(R.id.log_in_back_button);
        logInUsernameField = (EditText) findViewById(R.id.log_in_username_field);
        logInPasswordField = (EditText) findViewById(R.id.log_in_password_field);
        logInSubmitButton = (Button) findViewById(R.id.log_in_submit_button);

        signUpBackButton.setOnClickListener(this);
        signUpSubmitButton.setOnClickListener(this);

        logInSubmitButton.setOnClickListener(this);
        logInBackButton.setOnClickListener(this);

        logInButton.setOnClickListener(this);
        signUpButton.setOnClickListener(this);
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
        if(v == logInButton) {
            switchToView(SplashActionLayout.LOGIN, v);
        }

        if(v == logInSubmitButton) {
            logIn();
        }

        if(v == signUpButton) {
            switchToView(SplashActionLayout.SIGNUP, v);
        }

        if(v == signUpSubmitButton) {
            signUp();
        }

        if(v == signUpBackButton || v == logInBackButton) {
            switchToView(SplashActionLayout.BUTTON, v);
        }
    }

    private void switchToView(SplashActionLayout layout, View v) {
        //KeyboardUtil.hideKeyboard(v);

        switch(layout) {
            case BUTTON:
                buttonLayout.setVisibility(View.VISIBLE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.GONE);
                break;
            case LOGIN:
                buttonLayout.setVisibility(View.GONE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.VISIBLE);
                break;
            case SIGNUP:
                buttonLayout.setVisibility(View.GONE);
                signUpLayout.setVisibility(View.VISIBLE);
                logInLayout.setVisibility(View.GONE);
                break;
            default:
                buttonLayout.setVisibility(View.VISIBLE);
                signUpLayout.setVisibility(View.GONE);
                logInLayout.setVisibility(View.GONE);
        }
    }

    private void logIn() {
        goToHomeActivity();
    }

    private void signUp() {
        goToHomeActivity();
    }

    private void goToHomeActivity() {
        Intent homeActivityIntent = new Intent(this, HomeActivity.class);
        homeActivityIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        homeActivityIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(homeActivityIntent);
    }
}
