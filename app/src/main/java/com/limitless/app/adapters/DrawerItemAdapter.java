package com.limitless.app.adapters;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.limitless.app.data.DrawerItem;
import com.limitless.app.data.drawer.DrawerDataSource;
import com.limitless.app.views.DrawerListItemView;

/**
 * Created by anthonylipscomb on 3/25/15.
 */
public class DrawerItemAdapter extends BaseAdapter {
    private Context context;
    private DrawerDataSource dataSource;

    public DrawerItemAdapter(Context context) {
        this.context = context;
        dataSource = new DrawerDataSource();
    }

    @Override
    public int getCount() {
        return dataSource.getCount();
    }

    @Override
    public Object getItem(int position) {
        return dataSource.getDrawerItem(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if(convertView == null) {
            convertView = new DrawerListItemView(context);
        }

        DrawerListItemView view = (DrawerListItemView) convertView;
        view.setData((DrawerItem) getItem(position));

        return view;
    }
}
