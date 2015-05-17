package com.limitless.app.adapters;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.limitless.app.domainObjects.Post;
import com.limitless.app.enums.PostType;
import com.limitless.app.views.ImageListRowView;
import com.limitless.app.views.PostRowView;
import com.limitless.app.views.TextPostRowView;

import java.util.List;

/**
 * Created by anthonylipscomb on 3/17/15.
 */
public class PostItemAdapter extends BaseAdapter {
    private Context context;
    private List<Post> postList;

    public PostItemAdapter(Context c) {
        context = c;
    }

    public void setData(List<Post> posts) {
        postList = posts;
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return postList != null ? postList.size() : 0;
    }

    @Override
    public Object getItem(int position) {
        return postList != null ? postList.get(position) : null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        Post item = (Post) getItem(position);

        if(shouldInitializeConvertView(item, convertView)) {
            switch (item.getType()) {
                case Message:
                    convertView = new TextPostRowView(context);
                    break;
                case Image:
                    convertView = new ImageListRowView(context);
                    break;
            }
        }

        PostRowView itemView = (PostRowView) convertView;
        itemView.setData(item);

        return (View)itemView;
    }

    private boolean shouldInitializeConvertView(Post item, View view) {
        if(view == null) return true;

        if(item.getType() == PostType.Image && !(view instanceof ImageListRowView)) {
            return true;
        }

        if(item.getType() == PostType.Message && !(view instanceof TextPostRowView)) {
            return true;
        }

        return false;
    }
}
