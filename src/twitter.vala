/*
 * Copyright (C) 2016 Canonical, Inc
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
 * USA.
 *
 * Authors:
 *      Alberto Mardegan <alberto.mardegan@canonical.com>
 */

public class TwitterPlugin : Ap.OAuthPlugin {
    public TwitterPlugin (Ag.Account account) {
        Object (account: account);
    }

    protected override void query_username () {
        var reply = get_oauth_reply ();
        Variant? v_name = reply.lookup_value ("ScreenName", null);
        if (v_name != null) {
            account.set_display_name (v_name.get_string ());
        } else {
            v_name = reply.lookup_value ("UserId", null);
            if (v_name != null) {
                account.set_display_name (v_name.get_string ());
            }
        }

        store_account ();
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (TwitterPlugin);
}
