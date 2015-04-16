package com.limitless.app.adapters;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

import com.limitless.app.data.LimitlessDataSource;
import com.limitless.app.fragments.PostItemFragment;

/**
 * Created by anthonylipscomb on 4/15/15.
 */
public class PostHorizontalPagerAdapter extends FragmentStatePagerAdapter {
    LimitlessDataSource dataSource;

    public PostHorizontalPagerAdapter(FragmentManager fm) {
        super(fm);
        dataSource = LimitlessDataSource.get();
    }

    @Override
    public Fragment getItem(int position) {
        PostItemFragment fragment = new PostItemFragment();
        fragment.setPost(dataSource.getFeedItems().get(position));
        return fragment;
    }

    @Override
    public int getCount() {
        return dataSource.getFeedItems().size();
    }
}
