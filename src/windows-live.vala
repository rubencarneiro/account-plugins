/*
 * Copyright (C) 2012 Collabora Ltd.
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
 *      Xavier Claessens <xavier.claessens@collabora.co.uk>
 */

public class WindowsLivePlugin : Ap.OAuthPlugin {
    public WindowsLivePlugin (Ag.Account account) {
        Object (account: account);
    }

    construct
    {
        var oauth_params = new HashTable<string, GLib.Value?> (str_hash, null);
        oauth_params.insert ("Host", "login.live.com");
        oauth_params.insert ("AuthPath", "/oauth20_authorize.srf");
        oauth_params.insert ("TokenPath", "/oauth20_token.srf");
        oauth_params.insert ("RedirectUri", "https://login.live.com/oauth20_desktop.srf");
        oauth_params.insert ("ClientId", Config.WINDOWS_LIVE_CLIENT_ID);
        oauth_params.insert ("ResponseType", "code");
        string[] scopes = {
            "wl.messenger",
            "wl.offline_access",
            "wl.emails"
        };
        oauth_params.insert ("Scope", scopes);
        set_oauth_parameters (oauth_params);
        set_mechanism(Ap.OAuthMechanism.WEB_SERVER);
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (WindowsLivePlugin);
}
