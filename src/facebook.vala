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

public class FacebookPlugin : Ap.OAuthPlugin {
    private Soup.Session session;

    public FacebookPlugin (Ag.Account account) {
        Object (account: account);
    }

    private void fetch_username (string access_token) {
        debug ("fetching username, AT = " + access_token);
        Soup.URI destination_uri =
            new Soup.URI ("https://graph.facebook.com/me?access_token=" +
                          access_token);
        var message = new Soup.Message.from_uri ("GET", destination_uri);
        session = new Soup.Session ();
        session.queue_message (message, (sess, msg) => {
            debug ("Got message reply");
            string body = (string) msg.response_body.data;
            Json.Parser parser = new Json.Parser ();
            try {
                parser.load_from_data (body);

                Json.Node root = parser.get_root ();
                Json.Object response_object = root.get_object ();
                var username = response_object.get_string_member ("name");
                account.set_display_name (username);
            } catch (Error error) {
                warning ("Could not parse reply: " + body);
            }

            store_account ();
        });
    }

    protected override void query_username () {
        var reply = get_oauth_reply ();
        Variant? v_token = reply.lookup_value ("AccessToken", null);
        if (v_token != null) {
            fetch_username (v_token.get_string ());
        } else {
            store_account ();
        }
    }
}

public GLib.Type ap_module_get_object_type ()
{
    return typeof (FacebookPlugin);
}
