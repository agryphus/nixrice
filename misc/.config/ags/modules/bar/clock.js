const { exec, execAsync } = Utils;

export const Date = () => Widget.Button({
    child: Widget.Label({
        class_name: "module",
        setup: (self) => {
            self.poll(1000, (self) =>
                execAsync(["date", "+ %a %b %e"])
                    .then((time) => (self.label = time))
                    .catch(console.error),
            );
        },
    }),
    on_clicked: () => {
    },
});

export const Time = () => Widget.Button({
    child: Widget.Label({
        class_name: "module",
        setup: (self) => {
            self.poll(1000, (self) =>
                execAsync(["date", "+ %R"])
                    .then((time) => (self.label = time))
                    .catch(console.error),
            );
        },
    }),
    on_clicked: () => {
    },
});

