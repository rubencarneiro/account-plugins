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

public class GooglePlugin : Ap.OAuthPlugin {
    public GooglePlugin (Ag.Account account) {
        Object (account: account);
    }

    construct
    {
        var oauth_params = new HashTable<string, GLib.Value?> (str_hash, null);
        oauth_params.insert ("Host", "accounts.google.com");
        oauth_params.insert ("AuthPath", "o/oauth2/auth");
        oauth_params.insert ("RedirectUri",
                             "http://www.mardy.it/oauth2callback");
        oauth_params.insert ("ClientId", Config.GOOGLE_CLIENT_ID);
        oauth_params.insert ("ResponseType", "token");
        string[] scopes = {
            "https://docs.google.com/feeds/",
            "https://picasaweb.google.com/data/"
        };
        oauth_params.insert ("Scope", scopes);
        set_oauth_parameters (oauth_params);

        set_ignore_cookies (true);
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (GooglePlugin);
}
