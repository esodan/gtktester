/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 2; tab-width: 2 -*- */
/* gtkt-headerbar.vala
 *
 * Copyright (C) 2018 Daniel Espinosa
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

[GtkTemplate (ui="/org/gnome/gtkt-headerbar.ui")]
public class Gtkt.HeaderBar : Gtk.HeaderBar {
  Status _status = Status.PAUSE;
  [GtkChild]
  private Gtk.Image image;
  [GtkChild]
  private Gtk.Label lclosing;
  [GtkChild]
  private Gtk.Button bfails;
  [GtkChild]
  private Gtk.Button bnexttest;

  /**
   * Message to be displayed for test suite.
   */
  public string message {
    get {
      return lclosing.label;
    }
    set {
      lclosing.label = value;
    }
  }
  /**
   * Change {@link Status} of the test suite.
   */
  public Status status {
    get {
      return _status;
    }
    set {
      _status = value;
      switch (_status) {
        case Status.RUNNING:
          image.icon_name = "gtk-media-play";
          lclosing.label = "Closing automatically...";
        break;
        case Status.WAITTING:
          image.icon_name = "gtk-media-pause";
          lclosing.label = "Waiting for events...";
        break;
        case Status.SUCCESS:
          image.icon_name = "gtk-apply";
          lclosing.label = "Alls test passed";
        break;
        case Status.FAIL:
          image.icon_name = "gtk-dialog-warning";
          lclosing.label = "One or more tests fail";
        break;
        case Status.PAUSE:
          image.icon_name = "gtk-dialog-warning";
          lclosing.label = "Tests paused";
        break;
      }
    }
  }

  public int fails_number {
    get { return int.parse (bfails.label); }
    set { bfails.label = value.to_string (); }
  }

  public signal void next ();

  construct {
    bnexttest.clicked.connect (()=>{
      next ();
    });
  }
  public enum Status {
    RUNNING,
    WAITTING,
    PAUSE,
    SUCCESS,
    FAIL
  }
}
