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
 *      David King <david.king@canonical.com
 */

public class FoursquarePlugin : Ap.OAuthPlugin {
    public FoursquarePlugin (Ag.Account account) {
        Object (account: account);
    }

    construct
    {
        var oauth_params = new HashTable<string, GLib.Value?> (str_hash, null);
        oauth_params.insert ("Host", "foursquare.com");
        oauth_params.insert ("AuthPath", "/oauth2/authenticate");
        oauth_params.insert ("RedirectUri", "http://gwibber.com/0/auth.html");
        oauth_params.insert ("ClientId",
                             "BA0GOA0K3PTRS1KUJ5TTZ1P3GDRH3VJEEXY4N44ROPUJYKPW");
        oauth_params.insert ("ResponseType", "token");
        oauth_params.insert ("Display", "touch");
        set_oauth_parameters (oauth_params);
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (FoursquarePlugin);
}
