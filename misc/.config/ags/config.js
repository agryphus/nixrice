import { execAsync, timeout } from 'resource:///com/github/Aylur/ags/utils.js';
import { forMonitors } from "./utils.js";
import { Bar } from "./modules/bar/bar.js";
import { Popups } from './modules/popups/popups.js';

timeout(100, () => execAsync([
    'notify-send',
    'Notification Popup Example',
    'Lorem ipsum dolor sit amet, qui minim labore adipisicing ' +
    'minim sint cillum sint consectetur cupidatat.',
    '-A', 'Cool!',
    '-i', 'info-symbolic',
]));

// main scss file
const scss = `${App.configDir}/style.scss`

// target css file
const css = `${App.configDir}/style.css`

// make sure sassc is installed on your system
Utils.exec(`rm ${css} >/dev/null 2>&1`)
Utils.exec(`sassc ${scss} ${css}`)

// Main config
export default {
    style: `${App.configDir}/style.css`,
    windows: [
        ...forMonitors(Bar),
        Popups(0),
    ],
};

