package com.limitless.app.adapters;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.limitless.app.views.UserListRowView;
import com.parse.ParseUser;

import java.util.List;

/**
 * Created by anthonylipscomb on 3/25/15.
 */
public class UserListAdapter extends BaseAdapter {
    public static final String TAG = UserListAdapter.class.getName();

    private Context context;
    private List<ParseUser> data;

    public UserListAdapter(Context context) {
        this.context = context;
    }

    public void setData(List<ParseUser> data) {
        this.data = data;
        int size = data.size();
        int index = -1;
        for(int n = 0; n < size; n++) {
            if(this.data.get(n).getObjectId().equals(ParseUser.getCurrentUser().getObjectId())) {
                index = n;
                break;
            }
        }
        if(index > -1) this.data.remove(index);
        notifyDataSetChanged();

        Log.d(TAG, "Data length = " + this.data.size() + " " + index);
    }

    @Override
    public int getCount() {
        return data != null ? data.size() : 0;
    }

    @Override
    public Object getItem(int position) {
        return data != null ? data.get(position) : null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if(convertView == null) {
            convertView = new UserListRowView(context);
        }

        UserListRowView view = (UserListRowView) convertView;
        view.setData((ParseUser) getItem(position));
        return view;
    }
}
