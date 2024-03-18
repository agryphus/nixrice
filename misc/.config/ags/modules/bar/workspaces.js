const Hyprland = await Service.import("hyprland");

var monitorsActiveWorkspaceCache = new Array(10).fill(-1);

const is_active = (workspaceID) => {
    let monitorID = Hyprland.getWorkspace(workspaceID).monitorID;
    var monitor = Hyprland.getMonitor(monitorID);

    // Somewhat of a hack going on here.  For some reason, the 
    // Hyprland.monitors array only contains the monitorIDs up to the
    // currently focused one.  That means if I am currently focused on
    // monitor 0, then I cannot check what the focused workspace is on
    // monitor 3.  Thus, I had to create a global cache on top to reference
    // for when the result of Hyprland.getMonitor(monitorID) is undefined.
    let activeID = -1;
    if (monitor == undefined) {
        activeID = monitorsActiveWorkspaceCache[monitorID];
    } else {
        monitorsActiveWorkspaceCache[monitorID] = monitor.activeWorkspace.id;
        activeID = monitor.activeWorkspace.id;
    }
    return workspaceID == activeID;
}

export const Workspaces = (monitorID) => Widget.Box({
    class_name: 'workspaces',
    children: Hyprland.bind('workspaces').transform(ws => {
        return ws
            .filter(({ id, name }) => {
                if (name == "special") {
                    // Hyprland sometimes uses a special workspace, which 
                    // wouldn't appear on the bar.
                    return false;
                }

                // Only show the workspaces belonging to the monitor
                return Hyprland.getWorkspace(id).monitorID == monitorID;
            })
            .sort((a, b) => a.id - b.id) // Show in order of ID
            .map(({ id, name }) => Widget.Button({
                on_clicked: () => Hyprland.sendMessage(`dispatch workspace ${id}`),
                child: Widget.Label(`${name}`),
                class_name: Hyprland.active.workspace.bind('id')
                    .transform(i => `${is_active(id) ? 'focused' : ''}`),
        }));
    }),
});

export const ClientTitle = () => Widget.Label({
    class_name: 'module',
    label: Hyprland.active.client.bind('title'),
});

