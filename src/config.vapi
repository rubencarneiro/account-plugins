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
 *      Ken VanDine <ken.vandine@canonical.com>
 *      David King <david.king@canonical.com>
 */

[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "config.h")]
namespace Config {
  public const string TWITTER_CONSUMER_KEY;
  public const string TWITTER_CONSUMER_SECRET;
  public const string FACEBOOK_CLIENT_ID;
  public const string FLICKR_CONSUMER_KEY;
  public const string FLICKR_CONSUMER_SECRET;
  public const string GOOGLE_CLIENT_ID;
  public const string FOURSQUARE_CLIENT_ID;
  public const string IDENTICA_CONSUMER_KEY;
  public const string IDENTICA_CONSUMER_SECRET;
  public const string SINA_CONSUMER_KEY;
  public const string SINA_CONSUMER_SECRET;
  public const string SOHU_CONSUMER_KEY;
  public const string SOHU_CONSUMER_SECRET;
}
