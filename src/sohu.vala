/*
 * Copyright (C) 2012 Canonical, Inc
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
 *      David King <david.king@canonical.com>
 */

public class SohuPlugin : Ap.OAuthPlugin {
    public SohuPlugin (Ag.Account account) {
        Object (account: account);
    }

    construct
    {
        var oauth_params = new HashTable<string, GLib.Value?> (str_hash, null);
        oauth_params.insert ("RequestEndpoint",
                             "http://api.t.sohu.com/oauth/request_token");
        oauth_params.insert ("TokenEndpoint",
                             "http://api.t.sohu.com/oauth/access_token");
        oauth_params.insert ("AuthorizationEndpoint",
                             "http://api.t.sohu.com/oauth/authorize");
        oauth_params.insert ("ConsumerKey", Config.SOHU_CONSUMER_KEY);
        oauth_params.insert ("ConsumerSecret", Config.SOHU_CONSUMER_SECRET);
        oauth_params.insert ("Callback", "http://www.ubuntu.com/");
        string[] schemes = {
            "https",
            "http"
        };
        oauth_params.insert ("AllowedSchemes", schemes);
        set_oauth_parameters (oauth_params);

        set_mechanism (Ap.OAuthMechanism.HMAC_SHA1);
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (SohuPlugin);
}
