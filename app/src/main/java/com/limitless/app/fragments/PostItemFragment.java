package com.limitless.app.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.limitless.app.domainObjects.Post;
import com.limitless.app.enums.PostType;
import com.limitless.app.views.ImageListRowView;
import com.limitless.app.views.PostRowView;
import com.limitless.app.views.TextPostRowView;

/**
 * Created by anthonylipscomb on 4/15/15.
 */
public class PostItemFragment extends Fragment {
    private Post post;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        PostRowView rowView;

        if(post.getType() == PostType.Image) {
            rowView = new ImageListRowView(getActivity());
        } else {
            rowView = new TextPostRowView(getActivity());
        }

        rowView.setData(post);

        return rowView;
    }

    public void setPost(Post p) {
        this.post = p;
    }
}
