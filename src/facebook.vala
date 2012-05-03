/*
 * Copyright (C) 2012 Canonical, Inc
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
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

public class FacebookPlugin : Ap.OAuthPlugin {
    public FacebookPlugin (Ag.Account account) {
        Object (account: account);
    }

    construct
    {
        var oauth_params = new HashTable<string, GLib.Value?> (str_hash, null);
        oauth_params.insert ("Host", "www.facebook.com");
        oauth_params.insert ("AuthPath", "/dialog/oauth");
        oauth_params.insert ("RedirectUri",
                             "https://www.facebook.com/connect/login_success.html");
        oauth_params.insert ("ClientId", "302061903208115");
        oauth_params.insert ("Display", "popup");
        string[] scopes = {
            "publish_stream",
            "read_stream",
            "status_update",
            "offline_access",
            "user_photos",
            "friends_photos"
        };
        oauth_params.insert ("Scope", scopes);
        set_oauth_parameters (oauth_params);
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (FacebookPlugin);
}
