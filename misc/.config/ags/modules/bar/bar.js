const Network = await Service.import("network");
const Bluetooth = await Service.import("bluetooth");

// Widgets
import { Workspaces, ClientTitle } from "./workspaces.js";
import { Battery } from "./battery.js";
import { Date, Time } from "./clock.js";

const Left = (monitor) => Widget.Box({
    children: [
        Workspaces(monitor),
        ClientTitle(),
    ],
});

const Center = () => Widget.Box({
    children: [ ],
});

const Right = () => Widget.Box({
    hpack: "end",
    children: [
        Battery(),
        Date(),
        Time(),
    ],
});

const hyprlandMonitors = Utils.exec(`/bin/sh -c "hyprctl monitors | grep -o '(ID [0-9]*' | awk '{print $2}' | sort"`).split('\n').map(Number);

const getHyprlandMonitor = monitor => {
    if (monitor >= hyprlandMonitors.length) {
        return 0;
    }
    return hyprlandMonitors[monitor];
};

export const Bar = (monitor = 0) => Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: 'bar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(getHyprlandMonitor(monitor)),
        center_widget: Center(),
        end_widget: Right(),
    }),
});

