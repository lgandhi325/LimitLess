package com.limitless.app.data.drawer;

import com.limitless.app.data.DrawerItem;

/**
 * Created by anthonylipscomb on 3/25/15.
 */
public class DrawerDataSource {
    private String[] tabs = { "Feed", "Search", "Notifications", "Profile" };

    public DrawerItem getDrawerItem(int index) {
        DrawerItem item = new DrawerItem();
        item.title = tabs[index];

        switch (index) {
            case 0:
                item.type = DrawerItemType.Feed;
                break;
            case 1:
                item.type = DrawerItemType.Search;
                break;
            case 2:
                item.type = DrawerItemType.Notifications;
                break;
            case 3:
                item.type = DrawerItemType.Profile;
                break;
            default:
                return null;
        }
        return item;
    }

    public int getCount() {
        return tabs.length;
    }
}
