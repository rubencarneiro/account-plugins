/*
 * Copyright (C) 2012-2016 Canonical, Inc
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

public class GooglePlugin : Ap.OAuthPlugin {
    private Soup.Session session;

    public GooglePlugin (Ag.Account account) {
        Object (account: account);
    }

    construct
    {
        var oauth_params = new HashTable<string, GLib.Value?> (str_hash, null);

        /* Note the evil trick here: Google uses a couple of non-standard OAuth
         * parameters: "access_type" and "approval_prompt"; the signon OAuth
         * plugin doesn't (yet?) give us a way to provide extra parameters, so
         * we fool it by appending them to the value of the "AuthPath".
         *
         * We need to specify "access_type=offline" if we want Google to return
         * us a refresh token.
         * The "approval_prompt=force" string forces Google to ask for
         * authentication.
         */
        oauth_params.insert ("AuthPath",
                             "o/oauth2/auth?access_type=offline&approval_prompt=force");
        set_oauth_parameters (oauth_params);

        set_ignore_cookies (true);
    }

    private void fetch_username (string access_token) {
        debug ("fetching username, AT = " + access_token);
        Soup.URI destination_uri =
            new Soup.URI ("https://www.googleapis.com/oauth2/v3/userinfo");
        var message = new Soup.Message.from_uri ("POST", destination_uri);
        message.request_headers.append ("Authorization", "Bearer " + access_token);
        message.request_headers.set_content_length (0);
        session = new Soup.Session ();
        session.queue_message (message, (sess, msg) => {
            debug ("Got message reply");
            string body = (string) msg.response_body.data;
            Json.Parser parser = new Json.Parser ();
            try {
                parser.load_from_data (body);

                Json.Node root = parser.get_root ();
                Json.Object response_object = root.get_object ();
                var username = response_object.get_string_member ("email");
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
    return typeof (GooglePlugin);
}
