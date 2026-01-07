import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, window, shell } from "./utils";

const rules: KarabinerRules[] = [
  // Define the Hyper key itself
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            key_code: "escape",
          },
        ],
        type: "basic",
      },

      
      //      {
      //        type: "basic",
      //        description: "Disable CMD + Tab to force Hyper Key usage",
      //        from: {
      //          key_code: "tab",
      //          modifiers: {
      //            mandatory: ["left_command"],
      //          },
      //        },
      //        to: [
      //          {
      //            key_code: "tab",
      //          },
      //        ],
      //      },
    ],
  },


  {
    description: "escape -> caps lock",
    manipulators: [
      {
        from: {
          key_code: "escape",
          modifiers: {
            optional: ["any"]
          },
        },
        to: [
          {
            key_code: "vk_none",
            
          },
        ],
        to_if_alone: [
          {
            key_code: "vk_none"
          },
        ],
        type: "basic",
      },
    ],
  },


  {
    description: "left_command -> cmd+c if pressed alone",
    manipulators: [
      {
        from: {
          key_code: "left_command",
        },
        to: [
          {
            key_code: "left_command",
          },
        ],
        to_if_alone: [
          {
            key_code: "c",
            modifiers: ["command"],
            // or if instead you want to execute a script or command
            // shell_command: `/opt/homebrew/bin/SwitchAudioSource -s "AirPods Pro"; /opt/homebrew/bin/SwitchAudioSource -t input -s "AirPods Pro"`,
            //
            // You could also call a betterTouchTool action
          },
        ],
        type: "basic",
      },
    ],
  },


  {
    description: "left_option -> cmd+v if pressed alone",
    manipulators: [
      {
        from: {
          key_code: "left_option",
        },
        to: [
          {
            key_code: "left_option",
          },
        ],
        to_if_alone: [
          {
            key_code: "v",
            modifiers: ["command"],
          },
        ],
        type: "basic",
      },
    ],
  },


  {
    description: "left_ctrl -> cmd+tab if pressed alone",
    manipulators: [
      {
        from: {
          key_code: "left_control",
        },
        to: [
          {
            key_code: "left_control",
          },
        ],
        to_if_alone: [
          {
            key_code: "tab",
            modifiers: ["command"],
          },
        ],
        type: "basic",
      },
    ],
  },      


  ...createHyperSubLayers({
    h: {
      to: [{ key_code: "left_arrow" }],
    },
    j: {
      to: [{ key_code: "down_arrow" }],
    },
    k: {
      to: [{ key_code: "up_arrow" }],
    },
    l: {
      to: [{ key_code: "right_arrow" }],
    },
    //spacebar: open(
    //  "raycast://extensions/stellate/mxstbr-commands/create-notion-todo"
    //),
    //// b = "B"rowse
    //b: {
    //  t: open("https://twitter.com"),
    //  // Quarterly "P"lan
    //  p: open("https://mxstbr.com/cal"),
    //  y: open("https://news.ycombinator.com"),
    //  f: open("https://facebook.com"),
    //  r: open("https://reddit.com"),
    //  h: open("https://hashnode.com/draft"),
    //},
    //// o = "Open" applications
    spacebar: {
      1: app("1Password"),
      b: app("Safari"),
      c: app("Facetime"),
      v: app("Zed"),
      d: app("Discord"),
      h: app("Slack"),  
      e: app("Superhuman"),
      n: app("Notion"),
      t: app("Ghostty"),
      // Open todo list managed via *H*ypersonic
      s: app("Spotify"),
      j: app("Visual Studio Code"), 
      z: app("zoom.us"), 
      // "M"arkdown (Reflect.app)
      m: app("Reflect"),
      r: app("Reflect"),
      f: app("Finder"),
      // "i"Message 
      i: app("Texts"),
      p: {to: [{key_code: "caps_lock"}]},
      a: app("iA Presenter"),
      // "W"hatsApp has been replaced by Texts
      w: app("WhatsApp"),
      l: open(
        "raycast://extensions/stellate/mxstbr-commands/open-mxs-is-shortlink"
      ),
    },
//
    //// TODO: This doesn't quite work yet.
    //// l = "Layouts" via Raycast's custom window management
    //// l: {
    ////   // Coding layout
    ////   c: shell`
    ////     open -a "Visual Studio Code.app"
    ////     sleep 0.2
    ////     open -g "raycast://customWindowManagementCommand?position=topLeft&relativeWidth=0.5"
//
    ////     open -a "Terminal.app"
    ////     sleep 0.2
    ////     open -g "raycast://customWindowManagementCommand?position=topRight&relativeWidth=0.5"
    ////   `,
    //// },
//
    //// w = "Window"
    //w: {
    //  semicolon: {
    //    description: "Window: Hide",
    //    to: [
    //      {
    //        key_code: "h",
    //        modifiers: ["right_command"],
    //      },
    //    ],
    //  },
    //  y: window("previous-display"),
    //  o: window("next-display"),
    //  k: window("top-half"),
    //  j: window("bottom-half"),
    //  h: window("left-half"),
    //  l: window("right-half"),
    //  f: window("maximize"),
    //  u: {
    //    description: "Window: Previous Tab",
    //    to: [
    //      {
    //        key_code: "tab",
    //        modifiers: ["right_control", "right_shift"],
    //      },
    //    ],
    //  },
    //  i: {
    //    description: "Window: Next Tab",
    //    to: [
    //      {
    //        key_code: "tab",
    //        modifiers: ["right_control"],
    //      },
    //    ],
    //  },
    //  n: {
    //    description: "Window: Next Window",
    //    to: [
    //      {
    //        key_code: "grave_accent_and_tilde",
    //        modifiers: ["right_command"],
    //      },
    //    ],
    //  },
    //  b: {
    //    description: "Window: Back",
    //    to: [
    //      {
    //        key_code: "open_bracket",
    //        modifiers: ["right_command"],
    //      },
    //    ],
    //  },
    //  // Note: No literal connection. Both f and n are already taken.
    //  m: {
    //    description: "Window: Forward",
    //    to: [
    //      {
    //        key_code: "close_bracket",
    //        modifiers: ["right_command"],
    //      },
    //    ],
    //  },
    //},
//
    //// s = "System"
    //s: {
    //  u: {
    //    to: [
    //      {
    //        key_code: "volume_increment",
    //      },
    //    ],
    //  },
    //  j: {
    //    to: [
    //      {
    //        key_code: "volume_decrement",
    //      },
    //    ],
    //  },
    //  i: {
    //    to: [
    //      {
    //        key_code: "display_brightness_increment",
    //      },
    //    ],
    //  },
    //  k: {
    //    to: [
    //      {
    //        key_code: "display_brightness_decrement",
    //      },
    //    ],
    //  },
    //  l: {
    //    to: [
    //      {
    //        key_code: "q",
    //        modifiers: ["right_control", "right_command"],
    //      },
    //    ],
    //  },
    //  p: {
    //    to: [
    //      {
    //        key_code: "play_or_pause",
    //      },
    //    ],
    //  },
    //  semicolon: {
    //    to: [
    //      {
    //        key_code: "fastforward",
    //      },
    //    ],
    //  },
    //  e: open(
    //    `raycast://extensions/thomas/elgato-key-light/toggle?launchType=background`
    //  ),
    //  // "D"o not disturb toggle
    //  d: open(
    //    `raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`
    //  ),
    //  // "T"heme
    //  t: open(`raycast://extensions/raycast/system/toggle-system-appearance`),
    //  c: open("raycast://extensions/raycast/system/open-camera"),
    //  // 'v'oice
    //  v: {
    //    to: [
    //      {
    //        key_code: "spacebar",
    //        modifiers: ["left_option"],
    //      },
    //    ],
    //  },
    //},

    // v = "moVe" which isn't "m" because we want it to be on the left hand
    // so that hjkl work like they do in vim

    v: {
      // Magicmove via homerow.app
      m: {
        to: [{ key_code: "f", modifiers: ["right_control"] }],
        // TODO: Trigger Vim Easymotion when VSCode is focused
      },
      // Scroll mode via homerow.app
      s: {
        to: [{ key_code: "j", modifiers: ["right_control"] }],
      },
      d: {
        to: [{ key_code: "d", modifiers: ["right_shift", "right_command"] }],
      },
      u: {
        to: [{ key_code: "page_down" }],
      },
      i: {
        to: [{ key_code: "page_up" }],
      },
    },

    //// c = Musi*c* which isn't "m" because we want it to be on the left hand
    //c: {
    //  p: {
    //    to: [{ key_code: "play_or_pause" }],
    //  },
    //  n: {
    //    to: [{ key_code: "fastforward" }],
    //  },
    //  b: {
    //    to: [{ key_code: "rewind" }],
    //  },
    //},
//
    //// r = "Raycast"
    //r: {
    //  c: open("raycast://extensions/thomas/color-picker/pick-color"),
    //  n: open("raycast://script-commands/dismiss-notifications"),
    //  l: open(
    //    "raycast://extensions/stellate/mxstbr-commands/create-mxs-is-shortlink"
    //  ),
    //  e: open(
    //    "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"
    //  ),
    //  p: open("raycast://extensions/raycast/raycast/confetti"),
    //  a: open("raycast://extensions/raycast/raycast-ai/ai-chat"),
    //  s: open("raycast://extensions/peduarte/silent-mention/index"),
    //  h: open(
    //    "raycast://extensions/raycast/clipboard-history/clipboard-history"
    //  ),
    //  1: open(
    //    "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"
    //  ),
    //  2: open(
    //    "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"
    //  ),
    //},
  }),

  {
    description: "cmd+options+h -> cmd+options+left",
    manipulators: [
      {
        type: "basic",
        from: {
          key_code: "h",
          modifiers: {
            mandatory: ["left_option", "left_command"]
          }
        },
        to: [
          {
            key_code: "left_arrow",
            modifiers: ["left_command", "left_option"]
          },
        ],
      },
    ],
  },


  {
    description: "cmd+options+j -> cmd+options+down",
    manipulators: [
      {
        type: "basic",
        from: {
          key_code: "j",
          modifiers: {
            mandatory: ["left_option", "left_command"]
          }
        },
        to: [
          {
            key_code: "down_arrow",
            modifiers: ["left_command", "left_option"]
          },
        ],
      },
    ],
  },

    
  {
    description: "cmd+options+k -> cmd+options+up",
    manipulators: [
      {
        type: "basic",
        from: {
          key_code: "k",
          modifiers: {
            mandatory: ["left_option", "left_command"]
          }
        },
        to: [
          {
            key_code: "up_arrow",
            modifiers: ["left_command", "left_option"]
          },
        ],
      },
    ],
  },


  {
    description: "cmd+options+l -> cmd+options+right",
    manipulators: [
      {
        type: "basic",
        from: {
          key_code: "l",
          modifiers: {
            mandatory: ["left_option", "left_command"]
          }
        },
        to: [
          {
            key_code: "right_arrow",
            modifiers: ["left_command", "left_option"]
          },
        ],
      },
    ],
  },
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: true,
      },
      profiles: [
        {
          name: "Default",
          complex_modifications: {
            rules,
          },
        },
      ],
    },
    null,
    2
  )
);
