package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.ListView;

import com.limitless.app.R;
import com.limitless.app.adapters.UserListAdapter;
import com.parse.ParseUser;

import java.util.List;

/**
 * Created by anthonylipscomb on 3/25/15.
 */
public class UserSearchResultsView extends LinearLayout {
    private ListView listView;
    private UserListAdapter adapter;

    public UserSearchResultsView(Context context) {
        super(context);
        initialize(context);
    }

    public UserSearchResultsView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialize(context);
    }

    public UserSearchResultsView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initialize(context);
    }

    private void initialize(Context context) {
        if (isInEditMode()) return;

        LayoutInflater.from(context).inflate(R.layout.view_search, this);
        listView = (ListView) findViewById(R.id.results_list_view);
        adapter = new UserListAdapter(context);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(null);
        listView.setItemsCanFocus(false);
        listView.setFocusableInTouchMode(false);
        listView.setFocusable(false);
    }

    public void setData(List<ParseUser> data) {
        adapter.setData(data);
    }
}
