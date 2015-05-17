package com.limitless.app.views;

import android.content.Context;
import android.support.v4.widget.SwipeRefreshLayout;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.AbsListView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;

import com.limitless.app.R;
import com.limitless.app.adapters.PostItemAdapter;
import com.limitless.app.data.LimitlessDataSource;
import com.limitless.app.domainObjects.Post;
import com.limitless.app.domainObjects.UserFollows;
import com.limitless.app.interfaces.LimitLessGenericCallback;
import com.melnykov.fab.FloatingActionButton;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by anthonylipscomb on 3/17/15.
 */
public class PostListView extends LinearLayout implements SwipeRefreshLayout.OnRefreshListener, LimitLessGenericCallback<Void>{
    public static final String TAG = PostListView.class.getName();

    private LimitlessDataSource dataSource;
    private ListView listView;
    private PostItemAdapter adapter;
    //private FloatingActionButton fab;
    private SwipeRefreshLayout swipeRefreshLayout;

    private OnClickListener fabButtonListener;

    public PostListView(Context context) {
        super(context);
        initialize(context);
    }

    public PostListView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialize(context);
    }

    private void initialize(final Context context) {
        if(isInEditMode()) return;

        dataSource = LimitlessDataSource.get();

        LayoutInflater.from(context).inflate(R.layout.view_post_list, this);
        listView = (ListView) findViewById(android.R.id.list);
        //fab = (FloatingActionButton) findViewById(R.id.fab);
        swipeRefreshLayout = (SwipeRefreshLayout) findViewById(R.id.swipe_refresh_layout);

        swipeRefreshLayout.setRefreshing(true);
        listView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {

            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {
                int topRowVerticalPosition =
                        (listView == null || listView.getChildCount() == 0) ?
                                0 : listView.getChildAt(0).getTop();
                swipeRefreshLayout.setEnabled(firstVisibleItem == 0 && topRowVerticalPosition >= 0);
            }
        });

        swipeRefreshLayout.setOnRefreshListener(this);

        adapter = new PostItemAdapter(context);
        listView.setAdapter(adapter);
        //fab.attachToListView(listView);

        refresh();
    }

    public void refresh() {
        adapter.setData(dataSource.getFeedItems());
    }

    public void setFabButtonListener(OnClickListener fabButtonListener) {
        //fab.setOnClickListener(fabButtonListener);
    }

    @Override
    public void onRefresh() {
        dataSource.refresh(this);
    }

    @Override
    public void done(Void data) {
        refresh();
    }
}
