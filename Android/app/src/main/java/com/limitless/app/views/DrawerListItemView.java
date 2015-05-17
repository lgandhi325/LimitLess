package com.limitless.app.views;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.limitless.app.R;
import com.limitless.app.data.DrawerItem;

/**
 * Created by anthonylipscomb on 3/25/15.
 */
public class DrawerListItemView extends LinearLayout {
    private TextView title;

    public DrawerListItemView(Context context) {
        super(context);
        initialize(context);
    }

    public DrawerListItemView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialize(context);
    }

    public DrawerListItemView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initialize(context);
    }

    private void initialize(Context context) {
        if(isInEditMode()) return;

        LayoutInflater.from(context).inflate(R.layout.view_drawer_list_item, this);
        title = (TextView) findViewById(R.id.drawer_item_title);
    }

    public void setData(DrawerItem item) {
        title.setText(item.title);
    }
}
